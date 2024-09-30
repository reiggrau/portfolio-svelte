<script lang="ts">
    import { Label, Input, Textarea } from 'flowbite-svelte';
    import { EnvelopeSolid } from 'flowbite-svelte-icons';
	import { darkmode } from '$lib/store';
	import ArrowsDown from '../ArrowsDown.svelte';
	import SmallButton from '../SmallButton.svelte';

    import { enhance } from '$app/forms';

    export let form;

    function handleSubmit() {
        
    }
</script>

<div id="Projects" class="w-full h-screen flex mt-16">
	<div class="flex flex-col justify-center items-center w-[40%] {$darkmode ? 'ml-[50%] mr-[10%]' : 'ml-[10%]'} -mt-32">
		<ArrowsDown rotated/>
		<h1 class="text-3xl sm:text-4xl font-bold text-gray-300 inline border-b-2 border-cyan-500">
			Contact me
		</h1>
        <form action='?/sendEmail' method="POST" class='mt-4 w-[60%] flex flex-col gap-4 opacity-100 text-white' use:enhance>
            <Label class="text-white">Your Email
                <Input name='email' type="email" placeholder="your@email.com" on:keydown={(e)=> e.stopPropagation()}>
                    <EnvelopeSolid slot="left" class="w-4 h-4" />
                </Input>
            </Label>
            <Label class="text-white">Your Message
                <Textarea name='message' rows={6} placeholder='Write a message...' on:keydown={(e)=> e.stopPropagation()}/>
            </Label>
            <div class='flex justify-center'>
                <SmallButton submit>Submit</SmallButton>
            </div>
        </form>
	</div>
</div>
