@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  --header-h: 76px;
}

@layer base {
  html {
    scroll-behavior: smooth;
    scroll-padding-top: var(--header-h);
  }

  body {
    @apply bg-white text-ink antialiased font-sans;
    text-rendering: optimizeLegibility;
  }

  h1, h2, h3, h4 {
    @apply font-display;
    text-wrap: balance;
  }

  ::selection {
    @apply bg-laser/20 text-ink;
  }

  /* Sichtbarer Fokusring für Tastaturnavigation */
  :focus-visible {
    outline: 2px solid #007BFF;
    outline-offset: 3px;
    border-radius: 2px;
  }
}

@layer components {
  .container-x {
    @apply mx-auto w-full max-w-content px-6 sm:px-8 lg:px-10;
  }

  /* Eyebrow-Label im Markenstil */
  .eyebrow {
    @apply inline-flex items-center gap-2 text-xs font-semibold uppercase tracking-brand text-laser;
  }
  .eyebrow::before {
    content: "";
    @apply h-px w-8 bg-laser;
  }

  /* Signatur: feine Laserlinie als Section-Trenner */
  .laser-rule {
    height: 1px;
    background: linear-gradient(
      90deg,
      transparent,
      rgba(0, 123, 255, 0.6) 50%,
      transparent
    );
  }

  .btn-primary {
    @apply inline-flex items-center justify-center gap-2 rounded-full bg-laser px-7 py-3.5
           text-sm font-semibold text-white shadow-glow transition-all duration-300
           hover:bg-laser-600 hover:shadow-[0_0_50px_-6px_rgba(0,123,255,0.6)]
           focus-visible:outline-offset-4 active:scale-[0.98];
  }

  .btn-ghost {
    @apply inline-flex items-center justify-center gap-2 rounded-full border border-white/25
           px-7 py-3.5 text-sm font-semibold text-white transition-all duration-300
           hover:border-laser hover:text-laser-400 active:scale-[0.98];
  }

  .btn-ghost-dark {
    @apply inline-flex items-center justify-center gap-2 rounded-full border border-ink/15
           px-7 py-3.5 text-sm font-semibold text-ink transition-all duration-300
           hover:border-laser hover:text-laser active:scale-[0.98];
  }
}

/* Scroll-Reveal: standardmäßig versteckt, eingeblendet via JS-Klasse */
.reveal {
  opacity: 0;
  transform: translateY(28px);
  transition: opacity 0.7s ease-out, transform 0.7s ease-out;
  will-change: opacity, transform;
}
.reveal.is-visible {
  opacity: 1;
  transform: none;
}

@media (prefers-reduced-motion: reduce) {
  html {
    scroll-behavior: auto;
  }
  .reveal {
    opacity: 1;
    transform: none;
    transition: none;
  }
  .animate-laser-sweep,
  .animate-pulse-soft,
  .animate-fade-up {
    animation: none !important;
  }
}
