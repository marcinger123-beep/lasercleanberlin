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
