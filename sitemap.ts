import { NextResponse } from "next/server";

/**
 * Kontakt-Endpunkt.
 *
 * Aktuell wird die Anfrage nur validiert und protokolliert. Zum produktiven
 * Versand einer E-Mail binden Sie hier einen Dienst ein, z. B.:
 *   - Resend       (https://resend.com)
 *   - Nodemailer   (eigener SMTP-Server)
 *   - Postmark / SendGrid
 *
 * Die nötigen Zugangsdaten gehören als Umgebungsvariablen in Vercel
 * (Project → Settings → Environment Variables), NICHT in den Code.
 */
export async function POST(request: Request) {
  try {
    const form = await request.formData();

    const name = String(form.get("name") ?? "").trim();
    const email = String(form.get("email") ?? "").trim();
    const message = String(form.get("message") ?? "").trim();
    const phone = String(form.get("phone") ?? "").trim();
    const surface = String(form.get("surface") ?? "").trim();

    // Honeypot: gefüllt = Bot
    if (form.get("company")) {
      return NextResponse.json({ ok: true });
    }

    if (!name || !email || !message) {
      return NextResponse.json(
        { ok: false, error: "Pflichtfelder fehlen." },
        { status: 400 },
      );
    }

    const emailValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    if (!emailValid) {
      return NextResponse.json(
        { ok: false, error: "Ungültige E-Mail-Adresse." },
        { status: 400 },
      );
    }

    // TODO: Hier echten Versand einbinden. Beispiel mit Resend:
    //
    // import { Resend } from "resend";
    // const resend = new Resend(process.env.RESEND_API_KEY);
    // await resend.emails.send({
    //   from: "anfrage@lasercleanberlin.de",
    //   to: "info@lasercleanberlin.de",
    //   subject: `Neue Anfrage: ${surface || "Laserreinigung"} – ${name}`,
    //   replyTo: email,
    //   text: `Name: ${name}\nE-Mail: ${email}\nTelefon: ${phone}\nBereich: ${surface}\n\n${message}`,
    // });

    console.log("Neue Kontaktanfrage:", { name, email, phone, surface });

    return NextResponse.json({ ok: true });
  } catch (err) {
    console.error("Kontaktformular-Fehler:", err);
    return NextResponse.json(
      { ok: false, error: "Serverfehler." },
      { status: 500 },
    );
  }
}
