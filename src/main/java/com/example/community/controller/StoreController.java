package com.example.community.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.community.common.R;
import com.example.community.dto.StoreDto;
import com.example.community.entity.Sort;
import com.example.community.entity.Store;
import com.example.community.service.SortService;
import com.example.community.service.StoreService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/parking")
@Slf4j
public class StoreController {

    @Autowired
    private StoreService storeService;

    @Autowired
    private SortService sortService;

    @PostMapping
    public R<String> save(@RequestBody StoreDto storeDto){
        log.info("门店信息：{}", storeDto);

        storeService.save(storeDto);

        return R.success("新增门店成功");
    }

    @GetMapping("/page")
    public R<Page> page(int page,int pageSize,String name){
        //分页构造器对象
        Page<Store> pageInfo = new Page<>(page,pageSize);
        Page<StoreDto> dtoPage = new Page<>();

        LambdaQueryWrapper<Store> queryWrapper = new LambdaQueryWrapper<>();
        //添加查询条件，根据name进行like模糊查询
        queryWrapper.like(name != null, Store::getName,name);
        //添加排序条件，根据更新时间降序排列
        queryWrapper.orderByDesc(Store::getUpdateTime);

        storeService.page(pageInfo,queryWrapper);

        //对象拷贝
        BeanUtils.copyProperties(pageInfo,dtoPage,"records");
        List<Store> records = pageInfo.getRecords();

        List<StoreDto> list = records.stream().map((item) -> {
            StoreDto storeDto = new StoreDto();
            //对象拷贝
            BeanUtils.copyProperties(item, storeDto);
            //分类id
            Long categoryId = item.getCategoryId();
            //根据分类id查询分类对象
            Sort sort = sortService.getById(categoryId);
            if(sort != null){
                //分类名称
                String categoryName = sort.getName();
                storeDto.setCategoryName(categoryName);
            }
            return storeDto;
        }).collect(Collectors.toList());

        dtoPage.setRecords(list);
        return R.success(dtoPage);
    }

    @GetMapping("/{id}")
    public R<StoreDto> get(@PathVariable Long id){

        Store store = storeService.getById(id);

        StoreDto storeDto = new StoreDto();
        BeanUtils.copyProperties(store, storeDto);
        return R.success(storeDto);
    }

    @PutMapping
    public R<String> update(@RequestBody StoreDto storeDto){
        log.info(storeDto.toString());

        storeService.updateById(storeDto);

        return R.success("修改门店成功");
    }
    /**
     * 删除车位
     * @param id
     * @return
     */
    @DeleteMapping
    public R<String> delete(Long id){
        log.info("删除门店，id为：{}",id);
        storeService.removeById(id);
        return R.success("门店信息删除成功");
    }


    @GetMapping("/list")
    public R<List<Store>> list(Store store){
        LambdaQueryWrapper<Store> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(store.getCategoryId() != null, Store::getCategoryId, store.getCategoryId());
        queryWrapper.eq(store.getStatus() != null, Store::getStatus, store.getStatus());
        queryWrapper.orderByDesc(Store::getUpdateTime);

        List<Store> list = storeService.list(queryWrapper);

        return R.success(list);
    }

    @PutMapping("/status")
    public R<String> updateHouseStatus(@RequestParam("ids") String ids, @RequestParam("status") Integer status) {
        try {
            List<Long> idList = Arrays.stream(ids.split(","))
                    .map(Long::parseLong)
                    .collect(Collectors.toList());
            if (ids.contains(",")) {
                // 如果ids包含逗号，表示是批量修改
                storeService.updateBatchStatus(idList, status);
                return R.success("门店状态已经批量修改成功！");
            } else {
                // 否则，表示是单独修改
                storeService.updateStatus(idList.get(0), status);
                return R.success("门店状态已经单独修改成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return R.error("操作失败：" + e.getMessage());
        }
    }
}
