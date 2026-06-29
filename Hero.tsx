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
