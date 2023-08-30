import { computed, onMounted, onUnmounted, ref } from "vue"

export const useBreakpoints = () => {
  let windowWidth = ref(window.innerWidth)

  const onWidthChange = () => windowWidth.value = window.innerWidth
  onMounted(() => window.addEventListener('resize', onWidthChange))
  onUnmounted(() => window.removeEventListener('resize', onWidthChange))
  
  const type = computed(() => {
    if (windowWidth.value < 768) return 'sm'
    if (windowWidth.value >= 768 && windowWidth.value < 1024) return 'md'
    if (windowWidth.value >= 1024) return 'lg' 
    return undefined; // This is an unreachable line, simply to keep eslint happy.
  })

  const width = computed(() => windowWidth.value)

  return { width, type }
}