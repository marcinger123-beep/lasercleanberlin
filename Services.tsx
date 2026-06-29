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
