<template>
  <transition name="fade">
    <div class="modal-mask">
    <div @click.self="$emit('cancel')" class="modal" tabindex="">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">
              メモを削除しますか？
            </h5>
            <a @click="$emit('cancel')" class="close">
              <span aria-hidden="true">&times;</span>
            </a>
          </div>
          <div class="modal-body">
            完全に削除されます。
          </div>
          <div class="modal-footer">
            <a @click="$emit('ok')" class="btn btn-danger" tabindex="">削除</a>
          </div>
        </div>
      </div>
    </div>
    </div>
  </transition>
</template>

<style scoped lang="scss">
 .modal {
  display: block;
  }
.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: table;
  transition: opacity 0.3s ease;
}
  .fade-enter-active, .fade-leave-active {
    transition: opacity .15s;
  }
  .fade-enter, .fade-leave-to {
    opacity: 0;
  }
</style>
