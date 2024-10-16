<script lang="ts">
	import { Label, Input, Helper, Textarea } from 'flowbite-svelte';
	import { EnvelopeSolid } from 'flowbite-svelte-icons';
	import { darkmode } from '$lib/store';
	import ArrowsDown from '../ArrowsDown.svelte';
	import SmallButton from '../SmallButton.svelte';

	import { enhance } from '$app/forms';

	let email: string = '';
	let message: string = '';

	let emailError: string = '';
	let messageError: string = '';

	let buttonDisabled = false;
</script>

<div id="Projects" class="w-full h-screen flex mt-16">
	<div
		class="flex flex-col justify-center items-center w-[40%] {$darkmode
			? 'ml-[50%] mr-[10%]'
			: 'ml-[10%]'} -mt-32"
	>
		<ArrowsDown rotated />
		<h1 class="text-3xl sm:text-4xl font-bold text-gray-300 inline border-b-2 border-cyan-500">
			Contact me
		</h1>
		<form
			action="?/sendEmail"
			method="POST"
			class="mt-4 w-[60%] flex flex-col gap-4 opacity-100 text-white"
			use:enhance={({ formElement, formData, action, cancel, submitter }) => {
				buttonDisabled = true; // Prevent double sending

				// Frontend form checks
				if (!email) emailError = 'You must include an email!';

				if (email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) emailError = 'Wrong email format!';

				if (!message) messageError = 'You must include a message!';

				if (message.length > 280) messageError = 'Message must not exceed the character limit!';

				if (emailError || messageError) {
					cancel();
					buttonDisabled = false;
				}

				return async ({ result, update }) => {
					// Display success message
					if (result.status === 200) {
						email = '';
						message = '';
						alert('Email sent successfully!');
					}

					// Re-enable sending button
					buttonDisabled = false;
				};
			}}
		>
			<Label class="text-white"
				>Your Email
				<Input
					name="email"
					placeholder="your@email.com"
					bind:value={email}
					on:keydown={(e) => e.stopPropagation()}
					on:focus={() => (emailError = '')}
				>
					<EnvelopeSolid slot="left" class="w-4 h-4" />
				</Input>
				<Helper class="mt-1 h-2" color="red">
					<span class="font-medium {emailError ? 'opacity-100' : 'opacity-0'}">{emailError}</span>
				</Helper>
			</Label>
			<Label class="text-white"
				>Your Message
				<Textarea
					name="message"
					rows={7}
					placeholder="Write a message..."
					bind:value={message}
					on:keydown={(e) => e.stopPropagation()}
					on:focus={() => (messageError = '')}
				/>
				<div class="flex justify-between">
					<Helper class="mt-1 h-2" color="red">
						<span class="font-medium {messageError ? 'opacity-100' : 'opacity-0'}">
							{messageError}
						</span>
					</Helper>
					<Helper class="mt-1 h-2">
						<span class="font-bold {message.length > 280 ? 'text-red-500' : ''}">
							{message.length} / 280
						</span>
					</Helper>
				</div>
			</Label>
			<div class="flex justify-center">
				<SmallButton submit disabled={buttonDisabled}>Submit</SmallButton>
			</div>
		</form>
	</div>
</div>
