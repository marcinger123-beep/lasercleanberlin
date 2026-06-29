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
