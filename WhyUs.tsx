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
