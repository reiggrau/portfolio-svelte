import { fail } from '@sveltejs/kit';

export const actions = {
	sendEmail: async ({ request }) => {
		// TODO log the user in
        const data = await request.formData();

        const email = data.get('email');
        if (!email) {
			return fail(400, { email, missing: true });
		}

        const message = data.get('message');
        if (!message) {
			return fail(400, { message, missing: true });
		}
        
        console.log('SEND EMAIL :', data);
        return { success: true };
	}
};