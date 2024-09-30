import { fail } from '@sveltejs/kit';

import { Resend } from 'resend';

import { APIkey } from '$env/static/private';

// const resend = new Resend('re_123456789');
const resend = new Resend(APIkey);

export const actions = {
	sendEmail: async ({ request }) => {

        const data = await request.formData();
        console.log('data :', data);

        const email = data.get('email');
        const message = data.get('message');

        if (!email || !message) {
			return fail(400);
		}

        const { data: emailData, error } = await resend.emails.send({
                from: `ReigGrau Portfolio <onboarding@resend.dev>`,
                to: ['guillemreiggrau@gmail.com'],
                subject: `${email}`,
                html: `<strong>${message}</strong>`,
            });

        if (error) {
            return console.error({ error });
        }
        
        console.log('emailData :', emailData);
        return { success: true };

		// // TODO log the user in
        // const data = await request.formData();

        // const email = data.get('email');
        // if (!email) {
		// 	return fail(400, { email, missing: true });
		// }

        // const message = data.get('message');
        // if (!message) {
		// 	return fail(400, { message, missing: true });
		// }
        
        // // console.log('SEND EMAIL :', data);
        // return { success: true };
	}
};

// import { fail } from '@sveltejs/kit';

// export const actions = {
// 	sendEmail: async ({ request }) => {
// 		// TODO log the user in
//         const data = await request.formData();

//         const email = data.get('email');
//         if (!email) {
// 			return fail(400, { email, missing: true });
// 		}

//         const message = data.get('message');
//         if (!message) {
// 			return fail(400, { message, missing: true });
// 		}
        
//         // console.log('SEND EMAIL :', data);
//         return { success: true };
// 	}
// };