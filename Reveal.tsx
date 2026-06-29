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
