<template>
  <div v-if="open">
      <div v-if="html != null">
          <div v-html="html">
          </div>
      </div>
    <slot />
  </div>
</template>

<script>
export default {
  name: 'windows-portal',
  props: {
    width: {
      type: Number,
      default: 800,
    },
    height: {
      type: Number,
      default: 800,
    },
    left: {
      type: Number,
      default: 200,
    },
    top: {
      type: Number,
      default: 200,
    },
    open: {
      type: Boolean,
      default: false,
    },
    html:{
        type:String,
        default: null,
    }
  },
  data() {
    return {
      windowRef: null,
    }
  },
  watch: {
    open(newOpen) {
        console.log('opening', newOpen);
      if(newOpen) {
        this.openPortal();
      } else {
        this.closePortal();
      }
    }
  },
  methods: {
    openPortal() {
        console.log('portal opening')
      this.windowRef = window.open("", "", "width="+this.width, "height="+this.height, "left="+this.left, "top="+this.top);
      this.windowRef.addEventListener('beforeunload', this.closePortal);
      // magic!
      this.windowRef.document.body.appendChild(this.$el);
    },
    closePortal() {
      if(this.windowRef) {
        this.windowRef.close();
        this.windowRef = null;
        this.$emit('on-close');
      }
    }
  },
  mounted() {
    if(this.open) {
      this.openPortal();
    }
  },
  beforeDestroy() {
    if (this.windowRef) {
      this.closePortal();
    }
  }
}
</script>