import Vue from 'vue'
import MemoComponent from '../memo.vue'
import '../axios_config'
import '../validate_config'

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    render: h => h(MemoComponent)
  }).$mount()
  document.getElementById('memo').appendChild(app.$el)
})

// document.addEventListener('DOMContentLoaded', () => {
//    new Vue({
//      el: '#memo',
//      render: h => h(MemoComponent)
//    })
//  })
