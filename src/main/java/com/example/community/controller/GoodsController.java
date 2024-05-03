package com.example.community.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.community.common.R;
import com.example.community.dto.GoodsDto;
import com.example.community.entity.Goods;
import com.example.community.entity.Sort;
import com.example.community.service.SortService;
import com.example.community.service.GoodsService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


@RestController
@RequestMapping("/house")
@Slf4j
public class GoodsController {
    @Autowired
    private GoodsService goodsService;

    @Autowired
    private SortService sortService;


    @PostMapping
    public R<String> save(@RequestBody GoodsDto goodsDto){
        log.info(goodsDto.toString());

        goodsService.save(goodsDto);

        return R.success("新增商品成功");
    }

    @GetMapping("/page")
    public R<Page> page(int page,int pageSize,String name){

        //构造分页构造器对象
        Page<Goods> pageInfo = new Page<>(page,pageSize);
        Page<GoodsDto> houseDtoPage = new Page<>();

        //条件构造器
        LambdaQueryWrapper<Goods> queryWrapper = new LambdaQueryWrapper<>();
        //添加过滤条件
        queryWrapper.like(name != null, Goods::getName,name);
        //添加排序条件
        queryWrapper.orderByDesc(Goods::getUpdateTime);

        //执行分页查询
        goodsService.page(pageInfo,queryWrapper);

        //对象拷贝
        BeanUtils.copyProperties(pageInfo,houseDtoPage,"records");

        List<Goods> records = pageInfo.getRecords();

        List<GoodsDto> list = records.stream().map((item) -> {
            GoodsDto goodsDto = new GoodsDto();

            BeanUtils.copyProperties(item, goodsDto);

            Long categoryId = item.getCategoryId();
            //根据id查询分类对象
            Sort sort = sortService.getById(categoryId);

            if(sort != null){
                String categoryName = sort.getName();
                goodsDto.setCategoryName(categoryName);
            }
            return goodsDto;
        }).collect(Collectors.toList());

        houseDtoPage.setRecords(list);

        return R.success(houseDtoPage);
    }


    @GetMapping("/{id}")
    public R<GoodsDto> get(@PathVariable Long id){

        Goods goods = goodsService.getById(id);

        GoodsDto goodsDto = new GoodsDto();
        BeanUtils.copyProperties(goods, goodsDto);
        return R.success(goodsDto);
    }

    @PutMapping
    public R<String> update(@RequestBody GoodsDto goodsDto){
        log.info(goodsDto.toString());

        goodsService.updateById(goodsDto);

        return R.success("修改商品成功");
    }




    @GetMapping("/list")
    public R<List<GoodsDto>> list(Goods goods) {
        log.info("house:{}", goods);
        //条件构造器
        LambdaQueryWrapper<Goods> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.like(StringUtils.isNotEmpty(goods.getName()), Goods::getName, goods.getName());
        queryWrapper.eq(null != goods.getCategoryId(), Goods::getCategoryId, goods.getCategoryId());
        queryWrapper.eq(Goods::getStatus,1);
        queryWrapper.orderByDesc(Goods::getUpdateTime);

        List<Goods> good = goodsService.list(queryWrapper);

        List<GoodsDto> goodsDtos = good.stream().map(item -> {
            GoodsDto goodsDto = new GoodsDto();
            BeanUtils.copyProperties(item, goodsDto);
            Sort sort = sortService.getById(item.getCategoryId());
            if (sort != null) {
                goodsDto.setCategoryName(sort.getName());
            }

            return goodsDto;
        }).collect(Collectors.toList());

        return R.success(goodsDtos);
    }

    @PutMapping("/status")
    public R<String> updateHouseStatus(@RequestParam("ids") String ids, @RequestParam("status") Integer status) {
        try {
            List<Long> idList = Arrays.stream(ids.split(","))
                    .map(Long::parseLong)
                    .collect(Collectors.toList());
            if (ids.contains(",")) {
                // 如果ids包含逗号，表示是批量修改
                goodsService.updateBatchStatus(idList, status);
                return R.success("商品已经批量修改成功！");
            } else {
                // 否则，表示是单独修改
                goodsService.updateStatus(idList.get(0), status);
                return R.success("商品已经单独修改成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return R.error("操作失败：" + e.getMessage());
        }
    }

    @DeleteMapping
    public R<String> delete(Long id){
        log.info("删除商品，id为：{}",id);
        goodsService.removeById(id);
        return R.success("分类信息删除成功");
    }
}
