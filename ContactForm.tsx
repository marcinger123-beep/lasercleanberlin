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
