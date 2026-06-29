import Header from "@/components/Header";
import Hero from "@/components/Hero";
import BeforeAfter from "@/components/BeforeAfter";
import Services from "@/components/Services";
import WhyUs from "@/components/WhyUs";
import Process from "@/components/Process";
import Contact, { CONTACT } from "@/components/Contact";
import Footer from "@/components/Footer";
import { IconWhatsApp } from "@/components/icons";

export default function Home() {
  return (
    <>
      <Header />
      <main>
        <Hero />
        <Services />
        <BeforeAfter />
        <WhyUs />
        <Process />
        <Contact />
      </main>
      <Footer />

      {/* Schwebender WhatsApp-Button */}
      <a
        href={CONTACT.whatsappHref}
        target="_blank"
        rel="noopener noreferrer"
        aria-label="Über WhatsApp anfragen"
        className="fixed bottom-6 right-6 z-40 grid h-14 w-14 place-items-center rounded-full bg-laser text-white shadow-glow transition-transform hover:scale-105 active:scale-95"
      >
        <IconWhatsApp className="h-7 w-7" />
      </a>
    </>
  );
}
