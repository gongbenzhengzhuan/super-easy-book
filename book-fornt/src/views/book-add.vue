<template>
  <h3 class="dialog-head">新增书本信息</h3>
  <div class="mod-body">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" label-width="120px">
      <el-form-item label="书本图片" prop="picture">
        <el-upload
            class="upload-demo"
            action="http://localhost:8569/book/upload"
            :on-preview="handlePreview"
            :on-success="handleAvatarSuccess"
            :on-remove="handleRemove"
            :file-list="fileList"
            list-type="picture">
          <el-button size="small" type="primary">点击上传</el-button>
          <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>
        </el-upload>
      </el-form-item>
      <el-form-item label="书名" prop="name">
        <el-input v-model="dataForm.name" type="input" placeholder="请填写书名" style="width:350px"></el-input>
      </el-form-item>
      <el-form-item label="作者" prop="auth">
        <el-input v-model="dataForm.auth" type="input"  placeholder="请填写作者姓名" style="width:350px"></el-input>
      </el-form-item>
      <el-form-item label="介绍" prop="introduce">
        <el-input v-model="dataForm.introduce" type="textarea" :rows="2" placeholder="请填写介绍"></el-input>
      </el-form-item>
      <el-form-item label="定价" prop="price">
        <el-input v-model="dataForm.price" type="input" placeholder="请填写定价" style="width:350px"></el-input>
      </el-form-item>
      <el-form-item label="出版社" prop="publish">
        <el-input v-model="dataForm.publish" type="input" placeholder="请填写出版社" ></el-input>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
                  <el-button type="primary" @click="dataFormSubmit()">确定添加</el-button>
              </span>
  </div>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具 js，第三方插件 js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import {addBookInfo} from '@/api/book'
export default {
  //import 引入的组件需要注入到对象中才能使用
  components: {},
  props: {},
  data() {
    var validateContent = (rule, value, callback) => {
      if (!this.dataForm.content && !/\S/.test(value)) {
        callback(new Error('内容不能为空'))
      } else {
        callback()
      }
    }
    //这里存放数据
    return {
      fileList:[],
      param:{},
      dataList:[],
      dataForm:{
        price:'',
        name:'',
        picture:'',
        auth:'',
        publish:'',
        introduce:'',
      },
      pickerOptions: {},

      dataRule:{
        name:[
          {required:true,message:'不能为空',trigger:'blur'}
        ],
        auth:[
          {required:true,message:'不能为空',trigger:'blur'}
        ],
        introduce:[
          {required:true,message:'不能为空',trigger:'blur'}
        ],
        publish:[
          {required:true,message:'不能为空',trigger:'blur'}
        ],
        price:[
          {required:true,message:'不能为空',trigger:'blur'}
        ]
      }
    };
  },
  //计算属性 类似于 data 概念
  computed: {},
  //监控 data 中的数据变化
  watch: {},
  //方法集合
  methods: {
    //表单提交
    dataFormSubmit(){
      this.$refs['dataForm'].validate((valid) => {
        if(valid){
          console.log("进入dataFormSubmit方法了");
          this.param = {
            'picture':this.dataForm.picture,
            'name':this.dataForm.name,
            'introduce':this.dataForm.introduce,
            'publish':this.dataForm.publish,
            'auth':this.dataForm.auth,
            'price':this.dataForm.price,
          }
          addBookInfo(this.param).then((resp)=>{
            console.log("调用addBookInfo接口返回的数据是:",resp.data);
            const {code,message} = resp.data
            if(code ==='00000'){
              this.$message({
                message:'操作成功',
                type:'success',
                duration:1500,
                onClose:()=>{
                  this.dataForm={};
                  this.$router.push({path:'/'})
                }
              })
            }
          }).catch((error)=>{
            console.log(error);
          });
        }
      })
    },

    //上传图片
    handleRemove(file, fileList) {
      // console.log(file, fileList);
      // console.log("图片上传成功返回的访问路径是:",file.response.data);
      // console.log("此时dataForm里面picture路径是:",this.dataForm.picture);
    },
    handlePreview(file) {
      // console.log("图片上传成功返回的访问路径是:",file.response.data);
      // console.log(file);
    },
    handleAvatarSuccess(res, file) {
      console.log("图片上传成功返回的访问路径是:",file.response.data);
      this.dataForm.picture = file.response.data
      // console.log("此时dataForm里面picture路径是:",this.dataForm.picture);
    },
  },
  //生命周期 - 创建完成（可以访问当前 this 实例）
  created() {
  },
  //生命周期 - 挂载完成（可以访问 DOM 元素）
  mounted() {},
  beforeCreate() {}, //生命周期 - 创建之前
  beforeMount() {}, //生命周期 - 挂载之前
  beforeUpdate() {}, //生命周期 - 更新之前
  updated() {}, //生命周期 - 更新之后
  beforeDestroy() {}, //生命周期 - 销毁之前
  destroyed() {}, //生命周期 - 销毁完成
  activated() {} //如果页面有 keep-alive 缓存功能，这个函数会触发
};
</script>
<style lang="scss" scoped>
.dialog-footer{
  margin-left: 70%;
}

.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
