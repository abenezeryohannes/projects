<template>
    <section>
        <div>
            <div>

                <div @click="editing ? onClick() : 0" class="flex select-none" :class="[{'cursor-pointer': editing}]">
                    <div v-if="editing" class="mr-3 h-4 w-4 rounded hover:border-accent-light shadow-lg dark:hover:border-accent-dark
                                 border-gray-400 dark:border-gray-500 border-2 my-auto" @click.stop="onClick"
                        :class="[{ 'bg-accent-light': value }]" />
                    <div v-else class="my-auto mr-1">
                        <v-icon icon="save" cls="dark:text-accent-dark" fill="accent-light" :size="4" />
                    </div>

                    <div v-if="label != null" class="my-auto">
                        <p> {{ label }}</p>
                    </div>
                </div>

                <div v-if="error != null" class=" mb-3">
                    <p class="text-red-600 ml-2"> {{ error }}</p>
                </div>
            </div>
            <p v-if="error != null" class="my-auto" :name="label"> {{ value }}</p>
        </div>

    </section>
</template>

<script setup lang="ts">

import vIcon from '../icons/v-icon.vue'

const props = defineProps<{ value: boolean, error?: any, label?: string, editing?: boolean }>();
const emit = defineEmits<{
    (event: 'on-change', param: boolean): void
}>();
function onClick() {
    if (props.editing)
        emit('on-change', !props.value)
}
</script>

<style>

</style>