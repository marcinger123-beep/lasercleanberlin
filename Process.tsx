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
