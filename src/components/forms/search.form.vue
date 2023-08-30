<template>
    <section>

        <div>
            <div class="relative">

                <span class="absolute inset-y-0 left-0 flex items-center pl-2">
                    <button type="submit" class="p-1 focus:outline-none focus:shadow-outline">
                        <svg :class="['w-5', 'h-5']" class="text-gray-400" fill="none" stroke="currentColor"
                            stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24">
                            <path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                        </svg>
                    </button>
                </span>

                <input :class="[{ '  pr-2 text-sm py-2 shadow-lg rounded-xl font-bold': cls == null }, cls]" type="text"
                    name="field" autocomplete="off"
                    class="pl-10 w-full focus:outline-none dark:bg-background-darkish placeholder-gray-400 "
                    @input="$emit('on-change', ($event.target as HTMLInputElement).value)" :placeholder="placeholder" :value="value">
            </div>
        </div>

    </section>
</template>

<script setup lang="ts">import { watch } from 'vue';
 
const props = defineProps<{ value?: string | null, icon?: string, cls?: string, placeholder?: any }>();

const emit = defineEmits<{
    (event: 'on-change', param: any): void
}>();

watch(() => props.value, (newvalue, old) => {
    emit('on-change', newvalue)
}); 
</script>

<style>

</style>