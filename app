import type { MetadataRoute } from "next";

export default function robots(): MetadataRoute.Robots {
  return {
    rules: {
      userAgent: "*",
      allow: "/",
    },
    sitemap: "https://lasercleanberlin.de/sitemap.xml",
  };
}

@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  --header-h: 76px;
}

@layer base {
  html {
    scroll-behavior: smooth;
    scroll-padding-top: var(--header-h);
  }

  body {
    @apply bg-white text-ink antialiased font-sans;
    text-rendering: optimizeLegibility;
  }

  h1, h2, h3, h4 {
    @apply font-display;
    text-wrap: balance;
  }

  ::selection {
    @apply bg-laser/20 text-ink;
  }

  /* Sichtbarer Fokusring für Tastaturnavigation */
  :focus-visible {
    outline: 2px solid #007BFF;
    outline-offset: 3px;
    border-radius: 2px;
  }
}

@layer components {
  .container-x {
    @apply mx-auto w-full max-w-content px-6 sm:px-8 lg:px-10;
  }

  /* Eyebrow-Label im Markenstil */
  .eyebrow {
    @apply inline-flex items-center gap-2 text-xs font-semibold uppercase tracking-brand text-laser;
  }
  .eyebrow::before {
    content: "";
    @apply h-px w-8 bg-laser;
  }

  /* Signatur: feine Laserlinie als Section-Trenner */
  .laser-rule {
    height: 1px;
    background: linear-gradient(
      90deg,
      transparent,
      rgba(0, 123, 255, 0.6) 50%,
      transparent
    );
  }

  .btn-primary {
    @apply inline-flex items-center justify-center gap-2 rounded-full bg-laser px-7 py-3.5
           text-sm font-semibold text-white shadow-glow transition-all duration-300
           hover:bg-laser-600 hover:shadow-[0_0_50px_-6px_rgba(0,123,255,0.6)]
           focus-visible:outline-offset-4 active:scale-[0.98];
  }

  .btn-ghost {
    @apply inline-flex items-center justify-center gap-2 rounded-full border border-white/25
           px-7 py-3.5 text-sm font-semibold text-white transition-all duration-300
           hover:border-laser hover:text-laser-400 active:scale-[0.98];
  }

  .btn-ghost-dark {
    @apply inline-flex items-center justify-center gap-2 rounded-full border border-ink/15
           px-7 py-3.5 text-sm font-semibold text-ink transition-all duration-300
           hover:border-laser hover:text-laser active:scale-[0.98];
  }
}

/* Scroll-Reveal: standardmäßig versteckt, eingeblendet via JS-Klasse */
.reveal {
  opacity: 0;
  transform: translateY(28px);
  transition: opacity 0.7s ease-out, transform 0.7s ease-out;
  will-change: opacity, transform;
}
.reveal.is-visible {
  opacity: 1;
  transform: none;
}

@media (prefers-reduced-motion: reduce) {
  html {
    scroll-behavior: auto;
  }
  .reveal {
    opacity: 1;
    transform: none;
    transition: none;
  }
  .animate-laser-sweep,
  .animate-pulse-soft,
  .animate-fade-up {
    animation: none !important;
  }
}

import { NextResponse } from "next/server";

/**
 * Kontakt-Endpunkt.
 *
 * Aktuell wird die Anfrage nur validiert und protokolliert. Zum produktiven
 * Versand einer E-Mail binden Sie hier einen Dienst ein, z. B.:
 *   - Resend       (https://resend.com)
 *   - Nodemailer   (eigener SMTP-Server)
 *   - Postmark / SendGrid
 *
 * Die nötigen Zugangsdaten gehören als Umgebungsvariablen in Vercel
 * (Project → Settings → Environment Variables), NICHT in den Code.
 */
export async function POST(request: Request) {
  try {
    const form = await request.formData();

    const name = String(form.get("name") ?? "").trim();
    const email = String(form.get("email") ?? "").trim();
    const message = String(form.get("message") ?? "").trim();
    const phone = String(form.get("phone") ?? "").trim();
    const surface = String(form.get("surface") ?? "").trim();

    // Honeypot: gefüllt = Bot
    if (form.get("company")) {
      return NextResponse.json({ ok: true });
    }

    if (!name || !email || !message) {
      return NextResponse.json(
        { ok: false, error: "Pflichtfelder fehlen." },
        { status: 400 },
      );
    }

    const emailValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    if (!emailValid) {
      return NextResponse.json(
        { ok: false, error: "Ungültige E-Mail-Adresse." },
        { status: 400 },
      );
    }

    // TODO: Hier echten Versand einbinden. Beispiel mit Resend:
    //
    // import { Resend } from "resend";
    // const resend = new Resend(process.env.RESEND_API_KEY);
    // await resend.emails.send({
    //   from: "anfrage@lasercleanberlin.de",
    //   to: "info@lasercleanberlin.de",
    //   subject: `Neue Anfrage: ${surface || "Laserreinigung"} – ${name}`,
    //   replyTo: email,
    //   text: `Name: ${name}\nE-Mail: ${email}\nTelefon: ${phone}\nBereich: ${surface}\n\n${message}`,
    // });

    console.log("Neue Kontaktanfrage:", { name, email, phone, surface });

    return NextResponse.json({ ok: true });
  } catch (err) {
    console.error("Kontaktformular-Fehler:", err);
    return NextResponse.json(
      { ok: false, error: "Serverfehler." },
      { status: 500 },
    );
  }
}

import Header from "@/components/Header";
import Hero from "@/components/Hero";
import BeforeAfter from "@/components/BeforeAfter";
import Services from "@/components/Services";
import WhyUs from "@/components/WhyUs";
import Process from "@/components/Process";
import Contact, { CONTACT } from "@/components/Contact";
import Footer from "@/components/Footer";
import { IconWhatsApp } from "@/components/icons";

export default function Home() {
  return (
    <>
      <Header />
      <main>
        <Hero />
        <Services />
        <BeforeAfter />
        <WhyUs />
        <Process />
        <Contact />
      </main>
      <Footer />

      {/* Schwebender WhatsApp-Button */}
      <a
        href={CONTACT.whatsappHref}
        target="_blank"
        rel="noopener noreferrer"
        aria-label="Über WhatsApp anfragen"
        className="fixed bottom-6 right-6 z-40 grid h-14 w-14 place-items-center rounded-full bg-laser text-white shadow-glow transition-transform hover:scale-105 active:scale-95"
      >
        <IconWhatsApp className="h-7 w-7" />
      </a>
    </>
  );
}

import type { Metadata, Viewport } from "next";
import { Montserrat, Inter } from "next/font/google";
import "./globals.css";

const montserrat = Montserrat({
  subsets: ["latin"],
  weight: ["500", "600", "700", "800"],
  variable: "--font-montserrat",
  display: "swap",
});

const inter = Inter({
  subsets: ["latin"],
  weight: ["400", "500", "600"],
  variable: "--font-inter",
  display: "swap",
});

const siteUrl = "https://lasercleanberlin.de";

export const metadata: Metadata = {
  metadataBase: new URL(siteUrl),
  title: {
    default: "LaserClean Berlin – Professionelle Laserreinigung in Berlin",
    template: "%s | LaserClean Berlin",
  },
  description:
    "Präzise, materialschonende Laserreinigung in Berlin – ohne aggressive Chemikalien. Graffiti-, Rost- und Farbentfernung, Fassaden- und Industriereinigung. Jetzt kostenlose Anfrage stellen.",
  keywords: [
    "Laserreinigung Berlin",
    "Graffitientfernung Berlin",
    "Rostentfernung",
    "Fassadenreinigung Berlin",
    "Laser Reinigung",
    "Natursteinreinigung",
    "Industriereinigung Berlin",
    "Spezialreinigung",
  ],
  authors: [{ name: "LaserClean Berlin" }],
  creator: "LaserClean Berlin",
  publisher: "LaserClean Berlin",
  alternates: {
    canonical: siteUrl,
  },
  openGraph: {
    type: "website",
    locale: "de_DE",
    url: siteUrl,
    siteName: "LaserClean Berlin",
    title: "LaserClean Berlin – Professionelle Laserreinigung in Berlin",
    description:
      "Präzise. Materialschonend. Ohne aggressive Chemikalien. Premium-Laserreinigung für Hausverwaltungen, Gewerbe, Industrie und Privatkunden.",
    images: [
      {
        url: "/images/og-image.jpg",
        width: 1200,
        height: 630,
        alt: "LaserClean Berlin – Laserreinigung",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "LaserClean Berlin – Professionelle Laserreinigung",
    description:
      "Präzise. Materialschonend. Ohne aggressive Chemikalien.",
    images: ["/images/og-image.jpg"],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-image-preview": "large",
      "max-snippet": -1,
    },
  },
  category: "business",
};

export const viewport: Viewport = {
  themeColor: "#1A2330",
  width: "device-width",
  initialScale: 1,
};

const jsonLd = {
  "@context": "https://schema.org",
  "@type": "LocalBusiness",
  "@id": `${siteUrl}/#business`,
  name: "LaserClean Berlin",
  image: `${siteUrl}/images/og-image.jpg`,
  url: siteUrl,
  telephone: "+49 30 000000",
  email: "info@lasercleanberlin.de",
  priceRange: "€€",
  description:
    "Professionelle Laserreinigung in Berlin – präzise, materialschonend und ohne aggressive Chemikalien.",
  address: {
    "@type": "PostalAddress",
    addressLocality: "Berlin",
    addressCountry: "DE",
  },
  areaServed: {
    "@type": "City",
    name: "Berlin",
  },
  serviceType: [
    "Graffitientfernung",
    "Rostentfernung",
    "Farbentfernung",
    "Natursteinreinigung",
    "Fassadenreinigung",
    "Industriereinigung",
    "Metalloberflächenreinigung",
  ],
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="de" className={`${montserrat.variable} ${inter.variable}`}>
      <body>
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
        {children}
      </body>
    </html>
  );
}

import type { MetadataRoute } from "next";

export default function sitemap(): MetadataRoute.Sitemap {
  const base = "https://lasercleanberlin.de";
  const now = new Date();

  return [
    { url: base, lastModified: now, changeFrequency: "monthly", priority: 1 },
    { url: `${base}/#leistungen`, lastModified: now, changeFrequency: "monthly", priority: 0.8 },
    { url: `${base}/#vergleich`, lastModified: now, changeFrequency: "monthly", priority: 0.7 },
    { url: `${base}/#vorteile`, lastModified: now, changeFrequency: "monthly", priority: 0.6 },
    { url: `${base}/#ablauf`, lastModified: now, changeFrequency: "monthly", priority: 0.6 },
    { url: `${base}/#kontakt`, lastModified: now, changeFrequency: "monthly", priority: 0.9 },
  ];
}

"use client";

import { useCallback, useId, useRef, useState } from "react";
import Reveal from "./Reveal";

type Pair = {
  key: string;
  label: string;
  before: string; // Pfad zum Vorher-Bild
  after: string; // Pfad zum Nachher-Bild
  alt: string;
};

/* Lege die echten Bilder unter /public/images/ ab und passe die Pfade an.
   Solange keine Datei existiert, wird ein beschrifteter Platzhalter angezeigt. */
const pairs: Pair[] = [
  {
    key: "graffiti",
    label: "Graffiti",
    before: "/images/graffiti-vorher.jpg",
    after: "/images/graffiti-nachher.jpg",
    alt: "Graffitientfernung an Fassade",
  },
  {
    key: "rost",
    label: "Rost",
    before: "/images/rost-vorher.jpg",
    after: "/images/rost-nachher.jpg",
    alt: "Rostentfernung an Metall",
  },
  {
    key: "stein",
    label: "Naturstein",
    before: "/images/stein-vorher.jpg",
    after: "/images/stein-nachher.jpg",
    alt: "Natursteinreinigung",
  },
  {
    key: "fassade",
    label: "Fassade",
    before: "/images/fassade-vorher.jpg",
    after: "/images/fassade-nachher.jpg",
    alt: "Fassadenreinigung",
  },
];

export default function BeforeAfter() {
  const [active, setActive] = useState(0);
  const pair = pairs[active];

  return (
    <section id="vergleich" className="bg-white py-24 sm:py-28">
      <div className="container-x">
        <Reveal className="max-w-2xl">
          <p className="eyebrow">Sichtbarer Unterschied</p>
          <h2 className="mt-4 text-3xl font-bold tracking-tight text-ink sm:text-4xl">
            Vorher / Nachher
          </h2>
          <p className="mt-4 text-lg text-steel">
            Ziehen Sie den Regler und sehen Sie das Ergebnis – spurenfrei,
            ohne Schattenbildung, ohne Beschädigung der Oberfläche.
          </p>
        </Reveal>

        {/* Kategorie-Tabs */}
        <Reveal delay={80} className="mt-8 flex flex-wrap gap-2">
          {pairs.map((p, i) => (
            <button
              key={p.key}
              type="button"
              onClick={() => setActive(i)}
              className={`rounded-full px-5 py-2 text-sm font-semibold transition-all ${
                i === active
                  ? "bg-ink text-white"
                  : "bg-ink/5 text-ink/70 hover:bg-ink/10"
              }`}
            >
              {p.label}
            </button>
          ))}
        </Reveal>

        <Reveal delay={120} className="mt-8">
          <Slider key={pair.key} pair={pair} />
        </Reveal>
      </div>
    </section>
  );
}

function Slider({ pair }: { pair: Pair }) {
  const [pos, setPos] = useState(50);
  const containerRef = useRef<HTMLDivElement>(null);
  const dragging = useRef(false);
  const labelId = useId();

  const setFromClientX = useCallback((clientX: number) => {
    const el = containerRef.current;
    if (!el) return;
    const rect = el.getBoundingClientRect();
    const pct = ((clientX - rect.left) / rect.width) * 100;
    setPos(Math.min(100, Math.max(0, pct)));
  }, []);

  const onPointerDown = (e: React.PointerEvent) => {
    dragging.current = true;
    (e.target as HTMLElement).setPointerCapture?.(e.pointerId);
    setFromClientX(e.clientX);
  };
  const onPointerMove = (e: React.PointerEvent) => {
    if (!dragging.current) return;
    setFromClientX(e.clientX);
  };
  const onPointerUp = () => {
    dragging.current = false;
  };

  const onKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === "ArrowLeft") setPos((p) => Math.max(0, p - 4));
    if (e.key === "ArrowRight") setPos((p) => Math.min(100, p + 4));
    if (e.key === "Home") setPos(0);
    if (e.key === "End") setPos(100);
  };

  return (
    <div
      ref={containerRef}
      className="relative aspect-[16/10] w-full select-none overflow-hidden rounded-2xl bg-ink shadow-card sm:aspect-[16/9]"
      onPointerMove={onPointerMove}
      onPointerUp={onPointerUp}
      onPointerLeave={onPointerUp}
    >
      {/* Nachher (Basis) */}
      <Layer
        src={pair.after}
        alt={`${pair.alt} – nachher`}
        tone="after"
        badge="Nachher"
        badgeSide="right"
      />

      {/* Vorher (oben, beschnitten) */}
      <div
        className="absolute inset-0"
        style={{ clipPath: `inset(0 ${100 - pos}% 0 0)` }}
      >
        <Layer
          src={pair.before}
          alt={`${pair.alt} – vorher`}
          tone="before"
          badge="Vorher"
          badgeSide="left"
        />
      </div>

      {/* Griff */}
      <div
        className="absolute inset-y-0 z-10 flex items-center"
        style={{ left: `${pos}%`, transform: "translateX(-50%)" }}
      >
        <div className="relative h-full w-[2px] bg-laser shadow-[0_0_16px_rgba(0,123,255,0.7)]" />
        <button
          type="button"
          role="slider"
          aria-label="Vorher-Nachher-Regler"
          aria-labelledby={labelId}
          aria-valuemin={0}
          aria-valuemax={100}
          aria-valuenow={Math.round(pos)}
          aria-valuetext={`${Math.round(pos)}% Vorher sichtbar`}
          onPointerDown={onPointerDown}
          onKeyDown={onKeyDown}
          className="absolute left-1/2 top-1/2 grid h-12 w-12 -translate-x-1/2 -translate-y-1/2 cursor-ew-resize
                     place-items-center rounded-full bg-white text-ink shadow-glow ring-2 ring-laser
                     transition-transform active:scale-95"
        >
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <path d="m9 7-5 5 5 5M15 7l5 5-5 5" />
          </svg>
        </button>
      </div>

      <span id={labelId} className="sr-only">
        {pair.alt}: Vorher-Nachher-Vergleich
      </span>
    </div>
  );
}

function Layer({
  src,
  alt,
  tone,
  badge,
  badgeSide,
}: {
  src: string;
  alt: string;
  tone: "before" | "after";
  badge: string;
  badgeSide: "left" | "right";
}) {
  const [failed, setFailed] = useState(false);

  return (
    <div className="absolute inset-0 h-full w-full">
      {!failed ? (
        // eslint-disable-next-line @next/next/no-img-element
        <img
          src={src}
          alt={alt}
          className="h-full w-full object-cover"
          onError={() => setFailed(true)}
          draggable={false}
        />
      ) : (
        // Platzhalter, solange kein echtes Bild hinterlegt ist
        <div
          className={`flex h-full w-full items-center justify-center ${
            tone === "before"
              ? "bg-[linear-gradient(135deg,#2a3342,#1a2330)]"
              : "bg-[linear-gradient(135deg,#11161f,#1a2330)]"
          }`}
        >
          <div className="text-center">
            <p className="font-display text-sm font-bold uppercase tracking-brand text-white/40">
              {badge}
            </p>
            <p className="mt-2 text-xs text-white/30">Bild in /public/images</p>
          </div>
        </div>
      )}

      <span
        className={`absolute top-4 ${
          badgeSide === "left" ? "left-4" : "right-4"
        } rounded-full bg-ink/70 px-3 py-1 text-xs font-semibold uppercase tracking-wider text-white backdrop-blur`}
      >
        {badge}
      </span>
    </div>
  );
}

import { CONTACT } from "./Contact";

const cols = [
  {
    title: "Leistungen",
    links: [
      { label: "Graffiti entfernen", href: "#leistungen" },
      { label: "Rost entfernen", href: "#leistungen" },
      { label: "Farbe entfernen", href: "#leistungen" },
      { label: "Fassadenreinigung", href: "#leistungen" },
      { label: "Industriereinigung", href: "#leistungen" },
    ],
  },
  {
    title: "Unternehmen",
    links: [
      { label: "Vorteile", href: "#vorteile" },
      { label: "Ablauf", href: "#ablauf" },
      { label: "Vorher / Nachher", href: "#vergleich" },
      { label: "Kontakt", href: "#kontakt" },
    ],
  },
  {
    title: "Rechtliches",
    links: [
      { label: "Impressum", href: "/impressum" },
      { label: "Datenschutz", href: "/datenschutz" },
      { label: "AGB", href: "/agb" },
    ],
  },
];

export default function Footer() {
  const year = new Date().getFullYear();
  return (
    <footer className="bg-ink text-white">
      <div className="laser-rule" />
      <div className="container-x py-16">
        <div className="grid grid-cols-2 gap-10 sm:grid-cols-3 lg:grid-cols-5">
          {/* Marke */}
          <div className="col-span-2">
            <div className="flex items-center gap-2.5">
              <span className="grid h-9 w-9 place-items-center rounded-lg bg-white/10 ring-1 ring-white/20">
                <span className="font-display text-sm font-extrabold text-white">
                  L<span className="text-laser">C</span>
                </span>
              </span>
              <span className="font-display text-lg font-extrabold tracking-tight">
                LASER<span className="text-laser">CLEAN</span>{" "}
                <span className="text-white/50">Berlin</span>
              </span>
            </div>
            <p className="mt-4 max-w-xs text-sm text-white/55">
              Premium-Laserreinigung in Berlin. Präzise, materialschonend und
              ohne aggressive Chemikalien.
            </p>
            <div className="mt-6 space-y-1 text-sm text-white/70">
              <a href={CONTACT.phoneHref} className="block hover:text-laser-400">
                {CONTACT.phone}
              </a>
              <a
                href={`mailto:${CONTACT.email}`}
                className="block hover:text-laser-400"
              >
                {CONTACT.email}
              </a>
            </div>
          </div>

          {cols.map((col) => (
            <div key={col.title}>
              <h4 className="font-display text-sm font-bold uppercase tracking-wider text-white/80">
                {col.title}
              </h4>
              <ul className="mt-4 space-y-2.5">
                {col.links.map((l) => (
                  <li key={l.label}>
                    <a
                      href={l.href}
                      className="text-sm text-white/55 transition-colors hover:text-laser-400"
                    >
                      {l.label}
                    </a>
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>

        <div className="mt-12 flex flex-col items-start justify-between gap-3 border-t border-white/10 pt-6 text-xs text-white/40 sm:flex-row sm:items-center">
          <p>© {year} LaserClean Berlin. Alle Rechte vorbehalten.</p>
          <p>lasercleanberlin.de</p>
        </div>
      </div>
    </footer>
  );
}

import Reveal from "./Reveal";
import {
  IconNoChem,
  IconLeaf,
  IconPrecision,
  IconShield,
  IconSparkle,
  IconResidue,
  IconSurface,
  IconGlow,
} from "./icons";

const benefits = [
  { icon: IconNoChem, title: "Keine aggressiven Chemikalien", desc: "Reinigung allein mit Lichtenergie – ohne Lösungsmittel oder Beizen." },
  { icon: IconLeaf, title: "Umweltbewusste Technik", desc: "Kein Strahlmittel, kein Abwasser, kaum Entsorgungsaufwand." },
  { icon: IconPrecision, title: "Hohe Präzision & Kontrolle", desc: "Millimetergenau steuerbar – exakt dort, wo es nötig ist." },
  { icon: IconShield, title: "Materialschonend", desc: "Der Untergrund bleibt unversehrt, auch bei wiederholtem Einsatz." },
  { icon: IconSparkle, title: "Hochwertige Ergebnisse", desc: "Gleichmäßiges, sauberes Finish auf der gesamten Fläche." },
  { icon: IconResidue, title: "Minimale Rückstände", desc: "Nahezu staubfrei – wenig Reinigungsaufwand danach." },
  { icon: IconSurface, title: "Für empfindliche Oberflächen", desc: "Geeignet auch für Naturstein, Denkmal und filigrane Teile." },
  { icon: IconGlow, title: "Spurenfreies Entfernen", desc: "Ohne Schattenbildung – keine sichtbaren Übergänge." },
];

export default function WhyUs() {
  return (
    <section id="vorteile" className="relative overflow-hidden bg-ink-gradient py-24 text-white sm:py-28">
      <div
        className="pointer-events-none absolute inset-0 opacity-[0.05]"
        style={{
          backgroundImage:
            "linear-gradient(#fff 1px, transparent 1px), linear-gradient(90deg, #fff 1px, transparent 1px)",
          backgroundSize: "56px 56px",
        }}
        aria-hidden
      />
      <div className="container-x relative">
        <Reveal className="max-w-2xl">
          <p className="eyebrow !text-laser-400">Der Unterschied</p>
          <h2 className="mt-4 text-3xl font-bold tracking-tight sm:text-4xl">
            Warum LaserClean Berlin?
          </h2>
          <p className="mt-4 text-lg text-white/65">
            Laserreinigung ist die kontrollierteste Reinigungsmethode am Markt.
            Das sind die Vorteile, die für Ihr Projekt zählen.
          </p>
        </Reveal>

        <div className="mt-14 grid grid-cols-1 gap-x-10 gap-y-10 sm:grid-cols-2 lg:grid-cols-4">
          {benefits.map((b, i) => {
            const Icon = b.icon;
            return (
              <Reveal key={b.title} delay={(i % 4) * 70}>
                <span className="grid h-11 w-11 place-items-center rounded-lg bg-white/5 text-laser-400 ring-1 ring-white/10">
                  <Icon className="h-6 w-6" />
                </span>
                <h3 className="mt-4 font-display text-base font-bold">{b.title}</h3>
                <p className="mt-2 text-sm leading-relaxed text-white/60">{b.desc}</p>
              </Reveal>
            );
          })}
        </div>
      </div>
    </section>
  );
}

"use client";

import { useEffect, useState } from "react";
import { IconMenu, IconClose, IconPhone } from "./icons";

const links = [
  { href: "#leistungen", label: "Leistungen" },
  { href: "#vorteile", label: "Vorteile" },
  { href: "#ablauf", label: "Ablauf" },
  { href: "#vergleich", label: "Vorher / Nachher" },
  { href: "#kontakt", label: "Kontakt" },
];

export default function Header() {
  const [scrolled, setScrolled] = useState(false);
  const [open, setOpen] = useState(false);

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 16);
    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  useEffect(() => {
    document.body.style.overflow = open ? "hidden" : "";
    return () => {
      document.body.style.overflow = "";
    };
  }, [open]);

  return (
    <header
      className={`fixed inset-x-0 top-0 z-50 transition-all duration-300 ${
        scrolled
          ? "bg-white/90 shadow-card backdrop-blur-md"
          : "bg-transparent"
      }`}
    >
      <div className="container-x flex h-[76px] items-center justify-between">
        {/* Logo */}
        <a
          href="#top"
          className="group flex items-center gap-2.5"
          aria-label="LaserClean Berlin – Startseite"
        >
          <LogoMark scrolled={scrolled} />
          <span className="flex flex-col leading-none">
            <span
              className={`font-display text-[17px] font-extrabold tracking-tight ${
                scrolled ? "text-ink" : "text-white"
              }`}
            >
              LASER<span className="text-laser">CLEAN</span>
            </span>
            <span
              className={`text-[10px] font-semibold uppercase tracking-brand ${
                scrolled ? "text-steel" : "text-white/60"
              }`}
            >
              Berlin
            </span>
          </span>
        </a>

        {/* Desktop-Navigation */}
        <nav className="hidden items-center gap-8 lg:flex">
          {links.map((l) => (
            <a
              key={l.href}
              href={l.href}
              className={`text-sm font-medium transition-colors hover:text-laser ${
                scrolled ? "text-ink/80" : "text-white/80"
              }`}
            >
              {l.label}
            </a>
          ))}
          <a href="#kontakt" className="btn-primary !px-6 !py-2.5">
            Kostenlose Anfrage
          </a>
        </nav>

        {/* Mobile-Toggle */}
        <button
          type="button"
          onClick={() => setOpen((v) => !v)}
          aria-label={open ? "Menü schließen" : "Menü öffnen"}
          aria-expanded={open}
          className={`lg:hidden ${scrolled || open ? "text-ink" : "text-white"}`}
        >
          {open ? (
            <IconClose className="h-7 w-7" />
          ) : (
            <IconMenu className="h-7 w-7" />
          )}
        </button>
      </div>

      {/* Mobile-Menü */}
      <div
        className={`lg:hidden overflow-hidden bg-white transition-[max-height] duration-300 ${
          open ? "max-h-screen border-t border-ink/10" : "max-h-0"
        }`}
      >
        <nav className="container-x flex flex-col gap-1 py-4">
          {links.map((l) => (
            <a
              key={l.href}
              href={l.href}
              onClick={() => setOpen(false)}
              className="rounded-lg px-2 py-3 text-base font-medium text-ink/90 hover:bg-ink/5"
            >
              {l.label}
            </a>
          ))}
          <a
            href="#kontakt"
            onClick={() => setOpen(false)}
            className="btn-primary mt-3"
          >
            <IconPhone className="h-4 w-4" />
            Kostenlose Anfrage
          </a>
        </nav>
      </div>
    </header>
  );
}

function LogoMark({ scrolled }: { scrolled: boolean }) {
  return (
    <span
      className={`relative grid h-9 w-9 place-items-center rounded-lg transition-colors ${
        scrolled ? "bg-ink" : "bg-white/10 ring-1 ring-white/20"
      }`}
    >
      <span className="font-display text-sm font-extrabold tracking-tight text-white">
        L<span className="text-laser">C</span>
      </span>
    </span>
  );
}

import Reveal from "./Reveal";
import {
  IconSpray,
  IconRust,
  IconPaint,
  IconStone,
  IconFacade,
  IconIndustry,
  IconMetal,
} from "./icons";

const services = [
  {
    icon: IconSpray,
    title: "Graffiti entfernen",
    desc: "Rückstandsfreie Entfernung von Graffiti und Tags – ohne Schatten, ohne Beschädigung des Untergrunds.",
  },
  {
    icon: IconRust,
    title: "Rost entfernen",
    desc: "Präzises Entfernen von Flugrost und festem Rost an Stahl- und Metallbauteilen, blank bis zur Oberfläche.",
  },
  {
    icon: IconPaint,
    title: "Farbe entfernen",
    desc: "Lack- und Farbschichten von Metall und Holz lösen – kontrolliert, Schicht für Schicht.",
  },
  {
    icon: IconStone,
    title: "Naturstein reinigen",
    desc: "Schonende Reinigung empfindlicher Natursteine, ohne die Struktur anzugreifen.",
  },
  {
    icon: IconFacade,
    title: "Fassadenreinigung",
    desc: "Großflächige, gleichmäßige Reinigung von Fassaden – auch bei denkmalgeschützter Substanz.",
  },
  {
    icon: IconIndustry,
    title: "Industrieanlagen reinigen",
    desc: "Entfernung von Öl, Zunder und Ablagerungen an Maschinen und Anlagen im laufenden Betrieb.",
  },
  {
    icon: IconMetal,
    title: "Metalloberflächen reinigen",
    desc: "Vorbereitung und Reinigung von Metalloberflächen für Beschichtung, Schweißen oder Endmontage.",
  },
];

export default function Services() {
  return (
    <section id="leistungen" className="bg-white py-24 sm:py-28">
      <div className="container-x">
        <Reveal className="max-w-2xl">
          <p className="eyebrow">Anwendungsbereiche</p>
          <h2 className="mt-4 text-3xl font-bold tracking-tight text-ink sm:text-4xl">
            Leistungen
          </h2>
          <p className="mt-4 text-lg text-steel">
            Eine Technologie, viele Oberflächen. Wir entfernen, was stört –
            und schonen, was bleiben soll.
          </p>
        </Reveal>

        <div className="mt-12 grid grid-cols-1 gap-px overflow-hidden rounded-2xl bg-ink/10 sm:grid-cols-2 lg:grid-cols-3">
          {services.map((s, i) => {
            const Icon = s.icon;
            return (
              <Reveal
                key={s.title}
                delay={i * 60}
                as="article"
                className="group relative flex flex-col bg-white p-8 transition-colors hover:bg-ink-900"
              >
                <span className="grid h-12 w-12 place-items-center rounded-xl bg-laser/10 text-laser transition-colors group-hover:bg-laser group-hover:text-white">
                  <Icon className="h-6 w-6" />
                </span>
                <h3 className="mt-5 font-display text-lg font-bold text-ink transition-colors group-hover:text-white">
                  {s.title}
                </h3>
                <p className="mt-2 text-sm leading-relaxed text-steel transition-colors group-hover:text-white/70">
                  {s.desc}
                </p>
              </Reveal>
            );
          })}

          {/* Abschluss-Kachel als CTA */}
          <Reveal
            delay={services.length * 60}
            as="article"
            className="flex flex-col justify-between bg-ink-900 p-8 text-white"
          >
            <div>
              <h3 className="font-display text-lg font-bold">
                Ihre Oberfläche nicht dabei?
              </h3>
              <p className="mt-2 text-sm text-white/70">
                Wir prüfen jeden Fall individuell. Schicken Sie uns ein Foto –
                wir sagen Ihnen, ob Laserreinigung die richtige Methode ist.
              </p>
            </div>
            <a
              href="#kontakt"
              className="mt-6 inline-flex items-center gap-2 text-sm font-semibold text-laser-400 hover:text-laser"
            >
              Jetzt anfragen →
            </a>
          </Reveal>
        </div>
      </div>
    </section>
  );
}

import Reveal from "./Reveal";

const steps = [
  {
    n: "01",
    title: "Foto schicken",
    desc: "Senden Sie uns ein Foto der Oberfläche – per Formular, WhatsApp oder E-Mail.",
  },
  {
    n: "02",
    title: "Kostenloses Angebot erhalten",
    desc: "Wir bewerten Material, Verschmutzung und Aufwand und melden uns mit einem fairen Festpreis.",
  },
  {
    n: "03",
    title: "Termin vereinbaren",
    desc: "Sie wählen den passenden Termin – wir kommen mit der mobilen Lasertechnik zu Ihnen.",
  },
  {
    n: "04",
    title: "Reinigung durchführen",
    desc: "Saubere, spurenfreie Ausführung vor Ort – präzise und materialschonend.",
  },
];

export default function Process() {
  return (
    <section id="ablauf" className="bg-white py-24 sm:py-28">
      <div className="container-x">
        <Reveal className="max-w-2xl">
          <p className="eyebrow">In vier Schritten</p>
          <h2 className="mt-4 text-3xl font-bold tracking-tight text-ink sm:text-4xl">
            So funktioniert es
          </h2>
          <p className="mt-4 text-lg text-steel">
            Vom ersten Foto bis zum fertigen Ergebnis – unkompliziert und transparent.
          </p>
        </Reveal>

        <ol className="mt-14 grid grid-cols-1 gap-x-8 gap-y-12 sm:grid-cols-2 lg:grid-cols-4">
          {steps.map((s, i) => (
            <Reveal as="li" key={s.n} delay={i * 80} className="relative">
              {/* Verbindungslinie (Desktop) */}
              {i < steps.length - 1 && (
                <span
                  className="laser-rule absolute left-16 right-[-2rem] top-6 hidden lg:block"
                  aria-hidden
                />
              )}
              <span className="relative z-10 font-display text-5xl font-extrabold text-ink/10">
                {s.n}
              </span>
              <h3 className="mt-3 font-display text-lg font-bold text-ink">
                {s.title}
              </h3>
              <p className="mt-2 text-sm leading-relaxed text-steel">{s.desc}</p>
            </Reveal>
          ))}
        </ol>

        {/* Preis-Hinweis (keine festen m²-Preise) */}
        <Reveal delay={120} className="mt-16">
          <div className="overflow-hidden rounded-2xl border border-ink/10 bg-ink-900 text-white">
            <div className="grid gap-8 p-8 sm:grid-cols-[1fr_auto] sm:items-center sm:p-10">
              <div>
                <p className="eyebrow !text-laser-400">Transparente Preise</p>
                <h3 className="mt-3 font-display text-2xl font-bold">
                  Mindestauftrag ab 200&nbsp;€
                </h3>
                <p className="mt-3 max-w-xl text-white/65">
                  Typische Projekte liegen zwischen 200&nbsp;€ und 800&nbsp;€ –
                  abhängig von Oberfläche, Verschmutzung und Aufwand. Sie erhalten
                  vorab einen verbindlichen Festpreis, keine versteckten Kosten.
                </p>
              </div>
              <a href="#kontakt" className="btn-primary shrink-0">
                Festpreis anfragen
              </a>
            </div>
          </div>
        </Reveal>
      </div>
    </section>
  );
}

import Reveal from "./Reveal";
import ContactForm from "./ContactForm";
import { IconPhone, IconWhatsApp, IconMail, IconClock, IconPin } from "./icons";

/* Kontaktdaten zentral – hier echte Werte eintragen. */
export const CONTACT = {
  phone: "+49 30 000000",
  phoneHref: "tel:+493000000",
  whatsapp: "+49 170 0000000",
  whatsappHref: "https://wa.me/491700000000",
  email: "info@lasercleanberlin.de",
};

const channels = [
  {
    icon: IconPhone,
    label: "Telefon",
    value: CONTACT.phone,
    href: CONTACT.phoneHref,
  },
  {
    icon: IconWhatsApp,
    label: "WhatsApp",
    value: "Foto direkt senden",
    href: CONTACT.whatsappHref,
  },
  {
    icon: IconMail,
    label: "E-Mail",
    value: CONTACT.email,
    href: `mailto:${CONTACT.email}`,
  },
];

export default function Contact() {
  return (
    <section id="kontakt" className="bg-ink-900 py-24 text-white sm:py-28">
      <div className="container-x grid grid-cols-1 gap-12 lg:grid-cols-[0.9fr_1.1fr] lg:gap-16">
        {/* Linke Spalte */}
        <Reveal>
          <p className="eyebrow !text-laser-400">Kontakt</p>
          <h2 className="mt-4 text-3xl font-bold tracking-tight sm:text-4xl">
            Kostenlose Anfrage
          </h2>
          <p className="mt-4 max-w-md text-lg text-white/65">
            Schicken Sie uns ein Foto Ihrer Oberfläche. Sie erhalten ein
            unverbindliches Angebot mit verbindlichem Festpreis.
          </p>

          <div className="mt-10 space-y-3">
            {channels.map((c) => {
              const Icon = c.icon;
              return (
                <a
                  key={c.label}
                  href={c.href}
                  className="group flex items-center gap-4 rounded-xl border border-white/10 bg-white/[0.03] p-4 transition-colors hover:border-laser/40 hover:bg-white/[0.06]"
                >
                  <span className="grid h-11 w-11 place-items-center rounded-lg bg-laser/10 text-laser-400 transition-colors group-hover:bg-laser group-hover:text-white">
                    <Icon className="h-5 w-5" />
                  </span>
                  <span>
                    <span className="block text-xs uppercase tracking-wider text-white/40">
                      {c.label}
                    </span>
                    <span className="block font-semibold">{c.value}</span>
                  </span>
                </a>
              );
            })}
          </div>

          <div className="mt-8 space-y-2 text-sm text-white/50">
            <p className="flex items-center gap-2">
              <IconPin className="h-4 w-4 text-laser-400" />
              Einsatzgebiet: Berlin &amp; Umland
            </p>
            <p className="flex items-center gap-2">
              <IconClock className="h-4 w-4 text-laser-400" />
              Mo–Fr 8–18 Uhr · Antwort meist am selben Tag
            </p>
          </div>
        </Reveal>

        {/* Rechte Spalte: Formular */}
        <Reveal delay={100}>
          <ContactForm />
        </Reveal>
      </div>
    </section>
  );
}

import type { SVGProps } from "react";

type IconProps = SVGProps<SVGSVGElement>;

const base = {
  width: 24,
  height: 24,
  viewBox: "0 0 24 24",
  fill: "none",
  stroke: "currentColor",
  strokeWidth: 1.6,
  strokeLinecap: "round" as const,
  strokeLinejoin: "round" as const,
};

/* ---------- Leistungen ---------- */

export function IconSpray(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="M9 11h6a2 2 0 0 1 2 2v7a1 1 0 0 1-1 1H8a1 1 0 0 1-1-1v-7a2 2 0 0 1 2-2Z" />
      <path d="M9 11V7a2 2 0 0 1 2-2h2" />
      <path d="M15 5h3M15 8h4M17 2.5h2" />
      <path d="M11 15v3" />
    </svg>
  );
}

export function IconRust(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <circle cx="12" cy="12" r="8" />
      <path d="M12 8v.01M9.5 9.5v.01M14.5 9.5v.01M8.5 13v.01M15.5 13v.01M12 15v.01M10.5 11.5v.01M13.5 11.5v.01" />
    </svg>
  );
}

export function IconPaint(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="M4 7V5a1 1 0 0 1 1-1h11a1 1 0 0 1 1 1v2" />
      <path d="M17 5h2a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-7" />
      <path d="M4 7h8v3a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V7Z" />
      <path d="M10 11v3a2 2 0 0 1-2 2v3a1 1 0 0 0 2 0v-3a2 2 0 0 1-2-2" transform="translate(2 0)" />
      <path d="M10 16v5" />
    </svg>
  );
}

export function IconStone(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="m12 3 7 4v10l-7 4-7-4V7l7-4Z" />
      <path d="m12 3 7 4-7 4-7-4 7-4Z" />
      <path d="M12 11v10" />
    </svg>
  );
}

export function IconFacade(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <rect x="4" y="3" width="16" height="18" rx="1" />
      <path d="M8 7h2M14 7h2M8 11h2M14 11h2M8 15h2M14 15h2" />
      <path d="M10 21v-3a2 2 0 0 1 4 0v3" />
    </svg>
  );
}

export function IconIndustry(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="M3 21V10l5 3V10l5 3V8l8 4v9H3Z" />
      <path d="M7 5l-.5-2h2L8 5" />
      <path d="M7 17h1M11 17h1M15 17h1M19 17h1" />
    </svg>
  );
}

export function IconMetal(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="M4 8h16l-1.5 11a1 1 0 0 1-1 .9H6.5a1 1 0 0 1-1-.9L4 8Z" />
      <path d="M4 8 6 4h12l2 4" />
      <path d="M9 12l6 4M15 12l-6 4" />
    </svg>
  );
}

/* ---------- Vorteile ---------- */

export function IconLeaf(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="M5 19c0-9 6-13 14-13 0 8-4 14-13 14" />
      <path d="M5 19c2-5 5-8 9-9" />
    </svg>
  );
}

export function IconNoChem(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="M9 3h6M10 3v5l-4.5 9A2 2 0 0 0 7.3 20h9.4a2 2 0 0 0 1.8-3l-4.5-9V3" />
      <path d="m5 5 14 14" />
    </svg>
  );
}

export function IconPrecision(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <circle cx="12" cy="12" r="8" />
      <circle cx="12" cy="12" r="3.2" />
      <path d="M12 2v3M12 19v3M2 12h3M19 12h3" />
    </svg>
  );
}

export function IconShield(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="M12 3 5 6v6c0 4 3 6.5 7 9 4-2.5 7-5 7-9V6l-7-3Z" />
      <path d="m9.5 12 1.8 1.8L15 10" />
    </svg>
  );
}

export function IconSparkle(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="M12 3v18M3 12h18" opacity="0.35" />
      <path d="M12 5c.6 3.4 1.6 4.4 5 5-3.4.6-4.4 1.6-5 5-.6-3.4-1.6-4.4-5-5 3.4-.6 4.4-1.6 5-5Z" />
    </svg>
  );
}

export function IconResidue(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="M5 18h14" />
      <path d="M7 18c0-4 2-7 5-7s5 3 5 7" />
      <path d="M12 11V4M9.5 6.5 12 4l2.5 2.5" />
    </svg>
  );
}

export function IconSurface(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="m12 4 8 4.5-8 4.5-8-4.5L12 4Z" />
      <path d="M4 8.5v3l8 4.5 8-4.5v-3" />
      <path d="M4 12.5v3l8 4.5 8-4.5v-3" opacity="0.5" />
    </svg>
  );
}

export function IconGlow(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <circle cx="12" cy="12" r="4" />
      <path d="M12 2v3M12 19v3M2 12h3M19 12h3M5 5l2 2M17 17l2 2M19 5l-2 2M7 17l-2 2" />
    </svg>
  );
}

/* ---------- UI ---------- */

export function IconArrow(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="M5 12h14M13 6l6 6-6 6" />
    </svg>
  );
}

export function IconPhone(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="M5 4h4l2 5-2.5 1.5a11 11 0 0 0 5 5L20 13l2 5v3a1 1 0 0 1-1 1A17 17 0 0 1 4 5a1 1 0 0 1 1-1Z" />
    </svg>
  );
}

export function IconMail(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <rect x="3" y="5" width="18" height="14" rx="2" />
      <path d="m3 7 9 6 9-6" />
    </svg>
  );
}

export function IconWhatsApp(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="M3.5 20.5 5 16a8 8 0 1 1 3 3l-4.5 1.5Z" />
      <path d="M9 9c0 4 2 6 6 6 1 0 1.5-1 1-1.7-.3-.4-1.4-1-1.8-1-.5 0-.7.6-1.1.6-.6 0-2.6-1.4-2.6-2 0-.4.6-.6.6-1.1 0-.4-.6-1.5-1-1.8C9.9 7.5 9 8 9 9Z" />
    </svg>
  );
}

export function IconClock(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <circle cx="12" cy="12" r="9" />
      <path d="M12 7v5l3 2" />
    </svg>
  );
}

export function IconPin(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="M12 21s-6-5.2-6-10a6 6 0 1 1 12 0c0 4.8-6 10-6 10Z" />
      <circle cx="12" cy="11" r="2.2" />
    </svg>
  );
}

export function IconMenu(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="M4 7h16M4 12h16M4 17h16" />
    </svg>
  );
}

export function IconClose(props: IconProps) {
  return (
    <svg {...base} {...props}>
      <path d="m6 6 12 12M18 6 6 18" />
    </svg>
  );
}

"use client";

import { useState, type FormEvent } from "react";
import { IconArrow } from "./icons";

type Status = "idle" | "loading" | "success" | "error";

const surfaces = [
  "Graffiti entfernen",
  "Rost entfernen",
  "Farbe entfernen",
  "Naturstein reinigen",
  "Fassadenreinigung",
  "Industrieanlagen",
  "Metalloberflächen",
  "Sonstiges",
];

export default function ContactForm() {
  const [status, setStatus] = useState<Status>("idle");
  const [error, setError] = useState<string>("");

  async function onSubmit(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    setStatus("loading");
    setError("");

    const form = e.currentTarget;
    const data = new FormData(form);

    // Honeypot gegen Spam
    if (data.get("company")) {
      setStatus("success");
      form.reset();
      return;
    }

    try {
      const res = await fetch("/api/contact", {
        method: "POST",
        body: data,
      });
      if (!res.ok) throw new Error("Senden fehlgeschlagen");
      setStatus("success");
      form.reset();
    } catch (err) {
      setStatus("error");
      setError(
        "Die Nachricht konnte nicht gesendet werden. Bitte versuchen Sie es erneut oder kontaktieren Sie uns direkt.",
      );
    }
  }

  if (status === "success") {
    return (
      <div className="rounded-2xl border border-laser/20 bg-laser/5 p-8 text-center">
        <div className="mx-auto grid h-12 w-12 place-items-center rounded-full bg-laser text-white">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <path d="m5 12 5 5L20 7" />
          </svg>
        </div>
        <h3 className="mt-4 font-display text-xl font-bold text-ink">
          Vielen Dank!
        </h3>
        <p className="mt-2 text-steel">
          Ihre Anfrage ist eingegangen. Wir melden uns kurzfristig mit einem
          kostenlosen Angebot.
        </p>
        <button
          type="button"
          onClick={() => setStatus("idle")}
          className="mt-6 text-sm font-semibold text-laser hover:text-laser-600"
        >
          Weitere Anfrage senden
        </button>
      </div>
    );
  }

  return (
    <form
      onSubmit={onSubmit}
      className="rounded-2xl border border-ink/10 bg-white p-6 shadow-card sm:p-8"
    >
      <div className="grid grid-cols-1 gap-5 sm:grid-cols-2">
        <Field label="Name" name="name" required placeholder="Vor- und Nachname" />
        <Field label="E-Mail" name="email" type="email" required placeholder="name@beispiel.de" />
        <Field label="Telefon" name="phone" type="tel" placeholder="+49 …" />
        <div className="flex flex-col gap-1.5">
          <label htmlFor="surface" className="text-sm font-semibold text-ink">
            Anwendungsbereich
          </label>
          <select
            id="surface"
            name="surface"
            className="rounded-xl border border-ink/15 bg-white px-4 py-3 text-sm text-ink outline-none transition-colors focus:border-laser"
            defaultValue=""
          >
            <option value="" disabled>
              Bitte wählen
            </option>
            {surfaces.map((s) => (
              <option key={s} value={s}>
                {s}
              </option>
            ))}
          </select>
        </div>
      </div>

      <div className="mt-5 flex flex-col gap-1.5">
        <label htmlFor="message" className="text-sm font-semibold text-ink">
          Ihre Nachricht
        </label>
        <textarea
          id="message"
          name="message"
          rows={4}
          required
          placeholder="Beschreiben Sie kurz Oberfläche und Verschmutzung."
          className="resize-none rounded-xl border border-ink/15 bg-white px-4 py-3 text-sm text-ink outline-none transition-colors placeholder:text-steel/60 focus:border-laser"
        />
      </div>

      <div className="mt-5 flex flex-col gap-1.5">
        <label htmlFor="photo" className="text-sm font-semibold text-ink">
          Foto (optional)
        </label>
        <input
          id="photo"
          name="photo"
          type="file"
          accept="image/*"
          className="rounded-xl border border-dashed border-ink/20 bg-ink/[0.02] px-4 py-3 text-sm text-steel file:mr-4 file:rounded-full file:border-0 file:bg-ink file:px-4 file:py-2 file:text-xs file:font-semibold file:text-white hover:file:bg-ink-700"
        />
      </div>

      {/* Honeypot (versteckt) */}
      <input
        type="text"
        name="company"
        tabIndex={-1}
        autoComplete="off"
        className="absolute left-[-9999px]"
        aria-hidden
      />

      <label className="mt-5 flex items-start gap-3 text-xs text-steel">
        <input
          type="checkbox"
          name="privacy"
          required
          className="mt-0.5 h-4 w-4 rounded border-ink/30 text-laser focus:ring-laser"
        />
        <span>
          Ich habe die{" "}
          <a href="/datenschutz" className="text-laser underline">
            Datenschutzerklärung
          </a>{" "}
          gelesen und stimme der Verarbeitung meiner Daten zur Bearbeitung der
          Anfrage zu.
        </span>
      </label>

      {status === "error" && (
        <p className="mt-4 rounded-lg bg-red-50 px-4 py-3 text-sm text-red-700">
          {error}
        </p>
      )}

      <button
        type="submit"
        disabled={status === "loading"}
        className="btn-primary mt-6 w-full disabled:cursor-not-allowed disabled:opacity-60"
      >
        {status === "loading" ? "Wird gesendet …" : "Kostenlose Anfrage senden"}
        {status !== "loading" && <IconArrow className="h-4 w-4" />}
      </button>
    </form>
  );
}

function Field({
  label,
  name,
  type = "text",
  required,
  placeholder,
}: {
  label: string;
  name: string;
  type?: string;
  required?: boolean;
  placeholder?: string;
}) {
  return (
    <div className="flex flex-col gap-1.5">
      <label htmlFor={name} className="text-sm font-semibold text-ink">
        {label}
        {required && <span className="text-laser"> *</span>}
      </label>
      <input
        id={name}
        name={name}
        type={type}
        required={required}
        placeholder={placeholder}
        className="rounded-xl border border-ink/15 bg-white px-4 py-3 text-sm text-ink outline-none transition-colors placeholder:text-steel/60 focus:border-laser"
      />
    </div>
  );
}

"use client";

import { useEffect, useRef, type ReactNode } from "react";

type RevealProps = {
  children: ReactNode;
  className?: string;
  /** Verzögerung in ms für gestaffelte Effekte */
  delay?: number;
  as?: "div" | "section" | "li" | "article";
};

export default function Reveal({
  children,
  className = "",
  delay = 0,
  as = "div",
}: RevealProps) {
  const ref = useRef<HTMLElement>(null);

  useEffect(() => {
    const el = ref.current;
    if (!el) return;

    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            el.classList.add("is-visible");
            observer.unobserve(el);
          }
        });
      },
      { threshold: 0.12, rootMargin: "0px 0px -40px 0px" },
    );

    observer.observe(el);
    return () => observer.disconnect();
  }, []);

  const Tag = as as any;

  return (
    <Tag
      ref={ref}
      className={`reveal ${className}`}
      style={delay ? { transitionDelay: `${delay}ms` } : undefined}
    >
      {children}
    </Tag>
  );
}

import { IconArrow, IconPin, IconLeaf, IconPrecision } from "./icons";

export default function Hero() {
  return (
    <section
      id="top"
      className="relative isolate overflow-hidden bg-ink-gradient text-white"
    >
      {/* Hintergrund: Video-Platzhalter.
          Lege eine Datei unter /public/video/hero.mp4 + /public/images/hero-poster.jpg ab,
          dann wird sie automatisch geladen. Ohne Datei greift der Verlauf-Hintergrund. */}
      <div className="absolute inset-0 -z-10">
        <video
          className="h-full w-full object-cover opacity-40"
          autoPlay
          muted
          loop
          playsInline
          poster="/images/hero-poster.jpg"
        >
          <source src="/video/hero.mp4" type="video/mp4" />
        </video>
        {/* Verlauf für Lesbarkeit */}
        <div className="absolute inset-0 bg-gradient-to-b from-ink-900/70 via-ink-800/80 to-ink-900" />
      </div>

      {/* Dezentes Raster */}
      <div
        className="pointer-events-none absolute inset-0 -z-10 opacity-[0.06]"
        style={{
          backgroundImage:
            "linear-gradient(#fff 1px, transparent 1px), linear-gradient(90deg, #fff 1px, transparent 1px)",
          backgroundSize: "64px 64px",
        }}
        aria-hidden
      />

      <div className="container-x relative flex min-h-[92vh] flex-col justify-center pb-20 pt-36">
        <div className="max-w-3xl">
          <p className="eyebrow !text-laser-400 animate-fade-up">
            Laserreinigung · Berlin
          </p>

          {/* Signatur: Laserlinie, die einmal über die Überschrift fährt */}
          <div className="relative mt-6 overflow-hidden">
            <span
              className="pointer-events-none absolute left-0 top-1/2 h-[2px] w-1/2 -translate-y-1/2
                         bg-gradient-to-r from-transparent via-laser to-transparent animate-laser-sweep"
              aria-hidden
            />
            <h1
              className="animate-fade-up text-4xl font-extrabold leading-[1.05] tracking-tight sm:text-5xl lg:text-6xl"
              style={{ animationDelay: "80ms" }}
            >
              Professionelle{" "}
              <span className="text-laser">Laserreinigung</span> in Berlin
            </h1>
          </div>

          <p
            className="animate-fade-up mt-6 max-w-xl text-lg text-white/70 sm:text-xl"
            style={{ animationDelay: "160ms" }}
          >
            Präzise. Materialschonend. Ohne aggressive Chemikalien.
          </p>

          <div
            className="animate-fade-up mt-9 flex flex-col gap-3 sm:flex-row"
            style={{ animationDelay: "240ms" }}
          >
            <a href="#kontakt" className="btn-primary">
              Kostenlose Anfrage
              <IconArrow className="h-4 w-4" />
            </a>
            <a href="#vergleich" className="btn-ghost">
              Vorher / Nachher ansehen
            </a>
          </div>

          {/* Vertrauens-Leiste */}
          <ul
            className="animate-fade-up mt-14 grid max-w-xl grid-cols-1 gap-x-8 gap-y-3 text-sm text-white/60 sm:grid-cols-3"
            style={{ animationDelay: "320ms" }}
          >
            <li className="flex items-center gap-2">
              <IconLeaf className="h-4 w-4 text-laser-400" />
              Umweltbewusste Technik
            </li>
            <li className="flex items-center gap-2">
              <IconPrecision className="h-4 w-4 text-laser-400" />
              Höchste Präzision
            </li>
            <li className="flex items-center gap-2">
              <IconPin className="h-4 w-4 text-laser-400" />
              Vor Ort in ganz Berlin
            </li>
          </ul>
        </div>
      </div>

      {/* Abschluss-Laserlinie */}
      <div className="laser-rule" />
    </section>
  );
}

Hier kommen die echten Bilder hin.

Erwartete Dateien:
- og-image.jpg            (1200 x 630, Social-Media-Vorschau)
- hero-poster.jpg         (Standbild fuer das Hero-Video)
- graffiti-vorher.jpg / graffiti-nachher.jpg
- rost-vorher.jpg / rost-nachher.jpg
- stein-vorher.jpg / stein-nachher.jpg
- fassade-vorher.jpg / fassade-nachher.jpg

Solange keine Bilder vorhanden sind, zeigt die Seite saubere Platzhalter an.

Hier kommt das Hero-Hintergrundvideo hin: hero.mp4

Empfehlung: kurzes, ruhiges Loop-Video einer Laserreinigung,
moeglichst komprimiert (unter ~5 MB) fuer schnelle Ladezeiten.

# dependencies
/node_modules
/.pnp
.pnp.js

# testing
/coverage

# next.js
/.next/
/out/

# production
/build

# misc
.DS_Store
*.pem

# debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# local env files
.env*.local
.env

# vercel
.vercel

# typescript
*.tsbuildinfo
next-env.d.ts
