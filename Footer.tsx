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
