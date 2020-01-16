<template>
    <div>
        <p>{{msg}} world!</p>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                msg: 'hi'
            }
        },

        methods: {
            hello() {
                console.log("hello world!")
            }
        },
    }
</script>

<style>

</style>