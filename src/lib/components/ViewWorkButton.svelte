<!-- Thanks to Shawn @shawnrossouw: https://codepen.io/shawnrossouw -->
<!-- Source: https://codepen.io/shawnrossouw/pen/qeBxxb -->

<script>
    import { ArrowRightSolid } from 'flowbite-svelte-icons';
</script>

<button class="btn mt-4">
    <span class="line"></span>
    <span class='btn-content'>View my work <ArrowRightSolid size='sm'/></span>
</button>

<style lang='postcss'>
    @import url("https://fonts.googleapis.com/css?family=Roboto&display=swap");

    .btn {
        position: relative;
        border: solid 1px rgba(0, 214, 252, 0.3);
        background: none;
        color: rgba(0, 214, 252, 0.5);
        font-family: "Roboto", sans-serif;
        font-weight: normal;
        letter-spacing: 1.8px;
        width: 200px;
        height: 50px;
        padding: 0;
        outline: none;
    }
    .btn:hover {
        box-shadow: 1px 1px 8px rgba(0, 214, 252, 0.3);
        color: rgba(0, 214, 252, 1);
        text-shadow: 0 0 8px rgba(0, 214, 252, 0.4);
    }
    .btn-content {
        padding-left: 1.75rem;
        display: flex;
        align-items: center;
        gap: 1rem;
        transition: all 0.25s ease;
    }
    .btn:before {
        content: "";
        position: absolute;
        top: 0;
        left: 10%;
        width: 60px;
        height: 1px;
        transform: translateY(-1px);
        background: rgba(0, 214, 252, 1);
        transition: all 0.25s ease;
    }
    .btn:hover::before {
        left: 0;
        width: 20px;
    }
    .btn:after {
        content: "";
        position: absolute;
        bottom: 0;
        right: 10%;
        width: 60px;
        height: 1px;
        transform: translateY(1px);
        background: rgba(0, 214, 252, 1);
        transition: all 0.25s ease;
    }
    .btn:hover::after {
        right: 0;
        width: 20px;
    }
    .line:before {
        content: "";
        position: absolute;
        bottom: 30%;
        right: 0;
        width: 1px;
        height: 20px;
        transform: translateX(1px);
        background: rgba(0, 214, 252, 1);
        transition: all 0.25s ease;
    }
    .btn:hover .line:before {
        bottom: 0%;
    }
    .line:after {
        content: "";
        position: absolute;
        top: 30%;
        left: 0;
        width: 1px;
        height: 20px;
        transform: translateX(-1px);
        background: rgba(0, 214, 252, 1);
        transition: all 0.25s ease;
    }
    .btn:hover .line:after {
        top: 0;
    }
</style>