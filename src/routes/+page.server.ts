import { fail } from '@sveltejs/kit';

import { Resend } from 'resend';

import { RESEND_API_KEY } from '$env/static/private';

// const resend = new Resend('re_123456789');
const resend = new Resend(RESEND_API_KEY);

export const actions = {
	sendEmail: async ({ request }) => {
		const data = await request.formData();

		const email = data.get('email') as string;
		const message = data.get('message') as string;

		// Check email
		if (!email) {
			return fail(400, { email, missing: true });
		}

		if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
			return fail(400, { email, incorrect: true });
		}

		// Check message
		if (!message) {
			return fail(400, { message, missing: true });
		}

		if (message.length > 280) {
			return fail(400, { message, incorrect: true });
		}

		// Send email
		const { error } = await resend.emails.send({
			from: `ReigGrau Portfolio <onboarding@resend.dev>`,
			to: ['guillemreiggrau@gmail.com'],
			subject: `${email}`,
			html: `<strong>${message}</strong>`
		});

		// Handle error
		if (error) {
			console.error({ error });
			return fail(400, { message: error.message });
		}

		// Success response
		return { success: true };
	}
};
