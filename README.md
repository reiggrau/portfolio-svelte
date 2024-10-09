# Svelte & Tailwind + Flowbite Portfolio - By Reig-Grau

Hi! I'm Reig-Grau, and this is my portfolio's documentation.

Here I will explain how and why I built my page the way I did, but also guide you through the different steps that I took in case you decide to build a similar porfolio of your own.

So, without further ado, let's begin!

# SvelteKit

The first step after deciding to build an app is framework selection.

There are many options (Next, Vue, Svelte...) with their pros and cons, but in the end they more or less do the same, so yo can't go wrong by choosing the one you are more familiar with.

In my case I chose Svelte because it is the framework that I use in my full-time job and I am more comfortable with.

Once the decision is made, go to the framework's documentation and follow the steps to create a new project.

```bash
npm create svelte@latest <your app name>
cd <your app name>
npm install
npm run dev -- --open
```

A new tab should open with the newly-created app. Otherwise, go to http://localhost:5173

# Tailwind

Assuming you chose the 'skeleton app' when creating your Svelte app, you could start building your portfolio by changing the few pre-existing files and adding new ones, but there is a tool that I like to use to make the CSS part easier (in my opinion) and you might want to use too. This tool is called 'Tailwind'.

Tailwind is a CSS framework that has pre-existing CSS classes like 'flex, grid, text-center, etc.' that can be used to style the html elements directly in your Svelte pages and components.

With Tailwind you can move from this:

```bash
#example {
    padding: 0.875em 256px;
    margin-left: 16px;
    text-align: center;
    font-size: 12px;
}
```

To this:

```bash
<div id='example' class='py-[0.875em] px-64 ml-4 text-center text-xs'></div>
```

In order to add Tailwind to your project, go to their documentation page (Svelte version: https://tailwindcss.com/docs/guides/sveltekit) and follow the installation steps, the first one being:

```bash
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
```

Don't forget to follow the 'setup' steps that go next!

TIP: If you have many elements in your page or component that share the same Tailwind classes, intead of writing the same classes again and again, you can create a custom class in the 'stye' block of your Svelte file that applies all those Tailwind classes. The end result should look like this:

```bash
<div id='e1' class='example'></div>
<div id='e2' class='example'></div>
<div id='e3' class='example'></div>

<style lang="postcss">
    .example {
        @apply py-[0.875em] px-64 ml-4 text-center text-xs;
    }
</style>
```

WORK IN PROGRESS
