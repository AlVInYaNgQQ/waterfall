<template>
  <vue-waterfall-easy
    :imgsArr="imgsArr"
    @scrollReachBottom="handleReachBottom"
    :img-width="300"
    cardClass="cardStyle"
    @click="handleClick"
  >
    <template v-slot:header="headerProps">
      <div style="width: 100%; height: 100%; overflow: hidden">
        <div>{{ headerProps.data.headerText }}</div>
      </div>
    </template>
    <template v-slot:footer="footerProps">
      <div style="width: 100%; height: 100%; overflow: hidden">
        <div>{{ footerProps.data.info }}</div>
      </div>
    </template>
  </vue-waterfall-easy>
</template>

<script>
import vueWaterfallEasy from "../../src";
// import imageSet from "../../src/image-set";
import axios from 'axios'
 
export default {
  components: {
    vueWaterfallEasy,
  },
  data() {
    return {
      imgsArr: (() => {

        let tmp = [];
        // for (let i = 1; i < 14; i ++) {
        //   tmp.push({
        //     src: `../image-set/0${i < 10 ? '0' + String(i) : i}.jpg`, 
        //     info: ['可愛喵喵', '賣萌一下', '帶我回家', '拜託拜託'][Math.floor(Math.random() * 3)],
        //     headerText:'這個圖案有可愛吧！' 
        //   });
        // }
        return tmp
      })(),
      dbList: [],
    };
  },
  
  mounted() {
    console.log('mounted ');
    this.getWaterfall();
  },

  // mounted: {
  //   imgsArr : []
  //     // imgsArr: [ 
  //     //   {
  //     //     src: "../image-set/001.jpg", 
  //     //     info: "可愛喵喵",
  //     //     headerText:'测试' 
  // },

  methods: {
    getData: function () {},
    handleReachBottom:function(){
      this.imgsArr=this.imgsArr.concat(this.imgsArr);
      console.log("--this.imgsArr--",this.imgsArr)
    },
    handleClick:function(e,instance){
      console.log("==handleClick===",e,instance)
    },
    
    async httpReq({ url, data, ContentType = "application/json", _hash }) {

      let options = {
        mode: 'no-cors',
        headers: { "Content-Type": ContentType },
        method: "get",
        url: url,
        data:{}
      };

      return axios(options).then((res) => {
        return res.data;
      }).catch((error) => {
        console.error(error);
        return error;
      });
    },

    async getWaterfall() {

      try {
        // console.log('getWaterfall', 'http://127.0.0.1:4040/waterfall/list');
        let tmp = await this.httpReq({
          // url: 'http://127.0.0.1:4040/waterfall/list'
          url: 'https://app-xqjw36qysa-uc.a.run.app/waterfall/list'
        });

        if (tmp.code == 1000) {
          const list = tmp.result;
          const tmpImgs = this.imgsArr;
          let tmp2 = [];
          // this.dbList = tmp.result;
          for (let i = 0; i < list.length; i ++) {
            tmp2.push({
              src: list[i].ImageUrl, 
              href: "https://google.com",
              info: list[i].Description,
              headerText: list[i].Header 
            })
          }

          this.imgsArr = tmp2;

          console.log(tmp2);
        }

        console.log('tmp', tmp);
      } catch (errorCatch) {
        console.error(errorCatch);
      }
    }
  },
  
};
</script>

<style>
.cardStyle {
  box-shadow: rgba(0, 0, 0, 0.2) 0px 3px 1px -2px,
    rgba(0, 0, 0, 0.14) 0px 2px 2px 0px, rgba(0, 0, 0, 0.12) 0px 1px 5px 0px;
}
</style>