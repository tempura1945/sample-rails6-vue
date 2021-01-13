<template>
  <div>
    <div class="row">
      <div class="col-lg-12">
        <div class="card card-info card-outline">
          <div class="card-body">
            <h2 class="card-title mb-2">メモ</h2>
            <form v-on:submit.prevent="createMemo">
              <validation-observer ref="observer">
                <validation-provider v-slot="{ errors }" rules="required|max:20" name="名前">
                <input type="text" class="form-control m-2" placeholder="名前"  v-model="name" />
                  <p v-show="errors.length" class="m-2 text-danger">
                    {{ errors[0] }}
                  </p>
                </validation-provider>
                <validation-provider v-slot="{ errors }" rules="required|max:100" name="コメント">
                <textarea class="form-control m-2" rows="3" placeholder="コメント" v-model="comment" />
                  <p v-show="errors.length" class="m-2 text-danger">
                    {{ errors[0] }}
                  </p>
                </validation-provider>
              </validation-observer>
              <input :disabled='!isComplete' type="submit" value="登録" class="btn btn-info m-2" />
            </form>
          <div class="m-2 alert alert-info">{{status}}</div>
        </div>
      </div>
    </div>
  </div>
  <div class="row pb-2">
    <div class="col-lg-12">
      <div class="card-columns">
        <div v-for="(item, index) in memos" :key="index">

          <template v-if="!memos[index].edit">
            <div v-bind:key="item.id" class="card mt-1">
              <div class="card-header">
                {{item.name}}
              </div>
              <div class="card-body">
                {{item.comment}}
                <form>
                  <div v-bind:style="{textAlign: 'right'}">
                    <input type="submit" value="編集" class="btn btn-info" v-on:click.prevent="isEdit(index)" />
                    <button type="button" class="btn btn-danger" @click="deleteTarget = item; deleteIndex = index; showModal = true">削除</button>
                  </div>
                </form>
              </div>
            </div>
          </template>

          <template v-else>
            <div v-bind:key="item.id" class="card mt-1">
              <form v-on:submit.prevent="updateMemo(index, item.id, $event)" class="m-1">
                <div class="card-header">
                  <validation-provider v-slot="{ errors }" rules="required|max:20" name="名前">
                    <input type="text" v-model="item.name" name="name" class="form-control"/>
                      <p v-show="errors.length" class="m-2 text-danger">
                        {{ errors[0] }}
                      </p>
                  </validation-provider>
                </div>
                <div class="card-body">
                  <validation-provider v-slot="{ errors }" rules="required|max:100" name="コメント">
                    <textarea v-model="item.comment" name="comment" class="form-control" rows="5"/>
                      <p v-show="errors.length" class="m-2 text-danger">
                        {{ errors[0] }}
                      </p>
                  </validation-provider>
                </div>
                <div class="m-3" v-bind:style="{textAlign: 'right'}">
                  <input type="submit" value="キャンセル" class="btn btn-secondary" v-on:click.prevent="isEdit(index)" />
                  <input type="submit" value="更新" class="btn btn-info" />
                </div>
              </form>
            </div>
          </template>
        </div>
      </div>
    </div>
    </div>
    <modal v-if="showModal" @cancel="showModal = false" @ok="memoDelete(); showModal = false;" />
  </div>
</template>

<script>

import { format } from 'date-fns'
import ja from 'date-fns/locale/ja'
import axios from 'axios'
import Modal from './packs/components/Modal.vue'

export default {
  components: {
    Modal
  },
  data: function () {
    return {
      memos: [],
      name: '',
      comment: '',
      status: 'apiからの応答が表示されます',
      showModal: false,
      deleteTarget: -1,
      deleteIndex: -1
    }
  },

  created: function () {
    this.getMemos()
  },

  methods: {
    getMemos: function () {
      axios
        .get('/api/v1/memos')
        .then(
          (result) => {
            this.memos = result.data
            this.memos.forEach((memo, index) => {
              this.$set(this.memos[index], 'edit', false)
            })
          },
          (error) => {
            this.status = error.message
          }
        )
    },
    formatConversion: function (updated_at) {
      return format(new Date(Date.parse(updated_at)), 'yyyy年MM月dd日HH:mm:ss', { locale: ja })
    },

    createMemo: function (event) {
      if (this.name && this.comment) {
        axios
          .post('/api/v1/memos', { memo: { name: this.name, comment: this.comment } }, this.setHeaders())
          .then(result => {
            this.status = this.formatConversion(new Date()) + ' : ' + result.data.registration
            this.memos.unshift({
              id: result.data.id,
              name: result.data.name,
              edit: false,
              comment: result.data.comment,
              updated_at: result.data.updated_at
            }
            )
          })
          .catch(error => {
            console.error(error)
            if (error.response.data && error.response.data.errors) {
              this.errors = error.response.data.errors
            }
          })
        this.name = ''
        this.comment = ''
        this.$refs.observer.reset()
      }
    },

    updateMemo: function (index, id, event) {
      const formData = new FormData(event.target)
      const name = formData.get('name')
      const comment = formData.get('comment')

      if ((name.length == 0 || comment.length == 0) || (name.length > 20 || comment.length > 100)) {
        this.getMemos()
        this.status = this.formatConversion(new Date()) + ' : ' + '入力に誤りがあったためresetしました。'
        return
      }

      this.$set(this.memos[index], 'name', name)
      this.$set(this.memos[index], 'comment', comment)
      this.$set(this.memos[index], 'updated_at', new Date())

      axios
        .put('/api/v1/memos/' + id, { memo: { name: name, comment: comment } }, this.setHeaders())
        .then(result => {
          this.status = this.formatConversion(new Date()) + ' : ' + result.data.registration
          this.memos[index].edit = false
        })
        .catch(error => {
          console.error(error)
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors
          }
        })
    },

    memoDelete: function () {
      this.memos.splice(this.deleteIndex, 1)
      if (this.deleteTarget <= 0) {
        return
      }

      axios
        .delete('/api/v1/memos/' + this.deleteTarget.id, this.setHeaders())
        .then(result => {
          this.deleteTarget = -1
          this.deleteIndex = -1
          this.status = this.formatConversion(new Date()) + ' : ' + result.data.registration
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors
          }
        })
    },
    setHeaders: function () {
      const config = {
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json'
        }
      }
      return config
    },
    isEdit: function (index) {
      this.$set(this.memos[index], 'edit', !this.memos[index].edit)
    }
  },

  computed: {
    isComplete () {
      return this.name && this.comment
    }
  },
  watch: {
  }
}
</script>
<style>
</style>
