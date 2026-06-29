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
