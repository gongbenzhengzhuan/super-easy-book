<template>
  <div>
    <div class="mod-user">
      <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
        <el-form-item>
          <el-input v-model="dataForm.name" placeholder="书名" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-button @click="getDataList()" type="warning">查询</el-button>
          <el-button @click="addOneBookInfo()" type="success" plain>新增</el-button>
        </el-form-item>
      </el-form>
      <el-table :data="dataList" border v-loading="dataListLoading"  style="width: 100%;">
        <el-table-column prop="id" header-align="center" align="center" width="120" label="序号">
        </el-table-column>
        <el-table-column header-align="center" align="center" width="120" label="图片">
          <template v-slot="scope">
            <img v-if="scope.row.picture !== undefined" :src="scope.row.picture"  lazy style="width: 100px; height: 80px"/>
          </template>
        </el-table-column>
        <el-table-column prop="name" header-align="center" align="center" width="180" label="书名">
        </el-table-column>
        <el-table-column prop="auth" header-align="center" align="center" width="180" label="作者">
        </el-table-column>
        <el-table-column prop="introduce" header-align="center" align="center" width="340" label="介绍">
        </el-table-column>
        <el-table-column prop="price" header-align="center" align="center" width="180" label="价格">
        </el-table-column>
        <el-table-column prop="publish" header-align="center" align="center" width="180" label="出版社">
        </el-table-column>
        <el-table-column prop="gmtCreate" header-align="center" align="center" width="180" label="出版时间">
        </el-table-column>
        <el-table-column fixed="right" header-align="center" align="center" width="150" label="操作">
          <template  v-slot="scope">
            <el-button type="success" plain size="small" @click="updBookInfo(scope.row)">修改</el-button>
            <el-button type="danger" plain size="small" @click="deleteHandle(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <el-pagination
          @size-change="sizeChangeHandle"
          @current-change="currentChangeHandle"
          :current-page="current"
          :page-sizes="[10, 20, 50, 100]"
          :page-size="pageSize"
          :total="totalPage"
          layout="total, sizes, prev, pager, next, jumper">
      </el-pagination>

    </div>
  </div>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具 js，第三方插件 js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import { getBookInfoList,deleteOneBook } from '@/api/book';
export default {
//import 引入的组件需要注入到对象中才能使用
  components: {},
  props: {},
  data() {
//这里存放数据
    return {
      param:{},
      dataForm:{
        name:''
      },
      dataList: [],
      pastDataList:[],  //过滤数组
      current: 1,
      pageSize: 10,
      totalPage: 0,
      dataListLoading: false,
      dataListSelections: [],
    };
  },
//计算属性 类似于 data 概念
  computed: {},
//监控 data 中的数据变化
  watch: {},
//方法集合
  methods: {
    getDataList(){
      console.log("进入getDataList方法了");
      this.param = {
        "name":this.dataForm.name
      }
      this.dataListLoading = true;
      getBookInfoList(this.current,this.pageSize,this.param).then((resp)=>{
        console.log("调用getBookInfoList接口返回的数据是：",resp.data);
        const {code,message,data} = resp.data;
        if(code === '00000' && data && data.length != ""){
          this.dataList = data.records;
          this.totalPage = data.total;
        }else{
          this.dataList = [];
        }
        this.dataListLoading = false
      })
    },
    // 每页数
    sizeChangeHandle (val) {
      this.pageSize = val
      this.current = 1
      this.getDataList()
    },
    // 当前页
    currentChangeHandle (val) {
      this.current = val
      this.getDataList()
    },

    //新增书本商城信息
    addOneBookInfo(){
      this.$router.push({path:'book-add'});
    },

    //修改书城书本信息
    updBookInfo(row){
      console.log("要修改的书本信息是:",row);
      //this.$router.push({path:'/anotherPage',query:{id:1}});
      this.$router.push({path:'book-upd/'+row.id})
    },

    //删除
    deleteHandle(row){
      console.log("进入deleteHandle方法,要删除的那行数据是：",row);
      this.param = {
        'id':row.id
      }
      this.$confirm(`确定对这条数据进行删除删除操作吗，该操作执行成功后数据不可恢复?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(()=>{
        deleteOneBook(this.param).then((resp)=>{
          console.log("调用deleteOneBook接口返回的数据是:",resp.data);
          const{code} = resp.data
          if(code ==='00000'){
            this.$message({
              message:'操作成功',
              type:'success',
              duration:1500,
              onClose:()=>{
                this.getDataList()
              }
            })
          }else{
            this.$message({
              message:'操作失败',
              type:'error',
              duration:1500,
              onClose:()=>{
                this.getDataList()
              }
            })
          }
        }).catch((error)=>{})
      })
    },
  },
//生命周期 - 创建完成（可以访问当前 this 实例）
  created() {
    this.getDataList();
  },
//生命周期 - 挂载完成（可以访问 DOM 元素）
  mounted() {

  },
  beforeCreate() {}, //生命周期 - 创建之前
  beforeMount() {}, //生命周期 - 挂载之前
  beforeUpdate() {}, //生命周期 - 更新之前
  updated() {}, //生命周期 - 更新之后
  beforeDestroy() {}, //生命周期 - 销毁之前
  destroyed() {}, //生命周期 - 销毁完成
  activated() {}, //如果页面有 keep-alive 缓存功能，这个函数会触发
}
</script>
<style lang='scss' scoped>
//@import url(); 引入公共 css 类

</style>
