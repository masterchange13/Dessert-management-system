package com.example.community.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.community.common.CustomException;
import com.example.community.entity.Goods;
import com.example.community.entity.Sort;
import com.example.community.entity.Store;
import com.example.community.mapper.SortMapper;
import com.example.community.service.SortService;
import com.example.community.service.GoodsService;
import com.example.community.service.StoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SortServiceImpl extends ServiceImpl<SortMapper, Sort> implements SortService {

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private StoreService storeService;

    /**
     * 根据id删除分类，删除之前需要进行判断
     * @param id
     */
    @Override
    public void remove(Long id) {

        LambdaQueryWrapper<Goods> houseLambdaQueryWrapper = new LambdaQueryWrapper<>();
        //添加查询条件，根据分类id进行查询
        houseLambdaQueryWrapper.eq(Goods::getCategoryId,id);
        int count1 = goodsService.count(houseLambdaQueryWrapper);
        //查询当前分类是否关联了房屋，如果已经关联，抛出一个业务异常
        if(count1 > 0){
            //已经关联房屋，抛出一个业务异常
            throw new CustomException("当前分类下关联了商品，不能删除");
        }

        //查询当前分类是否关联了车位，如果已经关联，抛出一个业务异常
        LambdaQueryWrapper<Store> parkingLambdaQueryWrapper = new LambdaQueryWrapper<>();
        //添加查询条件，根据分类id进行查询
        parkingLambdaQueryWrapper.eq(Store::getCategoryId,id);
        int count2 = storeService.count(parkingLambdaQueryWrapper);
        if(count2 > 0){
            //已经关联车位，抛出一个业务异常
            throw new CustomException("当前分类下关联了门店，不能删除");
        }

        //正常删除分类
        super.removeById(id);
    }
}
