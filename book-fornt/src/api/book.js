import requset from '../utils/requsest'

// 获取书城列表分页条件查询
export function getBookInfoList(current,pageSize,param){
    return requset({
        url: `/book/list/${current}/${pageSize}`,
        method: 'post',
        data:param
    })
}

// 新增书城书本信息
export function addBookInfo(param){
    return requset({
        url: `/book/add-one-book`,
        method: 'post',
        data:param
    })
}

// 根据id获取书本信息
export function getBookInfoById(id){
    return requset({
        url: `/book/get-one-book/${id}`,
        method: 'get'
    })
}

// 根据id修改书本信息
export function updBookInfo(param){
    return requset({
        url: `/book/upd-one-book`,
        method: 'post',
        data:param
    })
}

// 删除一本书
export function deleteOneBook(param){
    return requset({
        url: `/book/delete-one-book`,
        method: 'post',
        data:param
    })
}
