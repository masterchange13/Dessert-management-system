package com.example.community.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.community.common.R;
import com.example.community.entity.Sort;
import com.example.community.service.SortService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 分类管理
 */
@RestController
@RequestMapping("/category")
@Slf4j
public class SortController {
    @Autowired
    private SortService sortService;

    /**
     * 新增分类
     * @param sort
     * @return
     */
    @PostMapping
    public R<String> save(@RequestBody Sort sort){
        log.info("category:{}", sort);
        sortService.save(sort);
        return R.success("新增分类成功");
    }

    /**
     * 分页查询
     * @param page
     * @param pageSize
     * @return
     */
    @GetMapping("/page")
    public R<Page> page(int page,int pageSize){
        //分页构造器
        Page<Sort> pageInfo = new Page<>(page,pageSize);
        //条件构造器
        LambdaQueryWrapper<Sort> queryWrapper = new LambdaQueryWrapper<>();
        //添加排序条件，根据sort进行排序
        queryWrapper.orderByAsc(Sort::getUpdateTime);

        //分页查询
        sortService.page(pageInfo,queryWrapper);
        return R.success(pageInfo);
    }

    @GetMapping("/{id}")
    public R<Sort> get(@PathVariable Long id){

        Sort sort = sortService.getById(id);

        return R.success(sort);
    }

    /**
     * 根据id删除分类
     * @param id
     * @return
     */
    @DeleteMapping
    public R<String> delete(Long id){
        log.info("删除分类，id为：{}",id);
        sortService.remove(id);
        return R.success("分类信息删除成功");
    }

    /**
     * 根据id修改分类信息
     * @param sort
     * @return
     */

    @PutMapping
    public R<String> update(HttpServletRequest request, @RequestBody Sort sort){
        long id = Thread.currentThread().getId();
        log.info("线程id为：{}",id);
        sort.setUpdateTime(LocalDateTime.now());//更新时间

        //获得当前登录用户的id
        Long empId = (Long) request.getSession().getAttribute("user");

        sort.setUpdateUser(empId);//更新人

        sortService.updateById(sort);
        return R.success("分类信息修改成功");
    }

    /**
     * 根据条件查询分类数据
     * @param sort
     * @return
     */
    @GetMapping("/list")
    public R<List<Sort>> list(Sort sort){
        //条件构造器
        LambdaQueryWrapper<Sort> queryWrapper = new LambdaQueryWrapper<>();
        //添加条件
        queryWrapper.eq(sort.getType() != null, Sort::getType, sort.getType());
        //添加排序条件
        queryWrapper.orderByAsc(Sort::getUpdateTime);

        List<Sort> list = sortService.list(queryWrapper);
        return R.success(list);
    }

}
