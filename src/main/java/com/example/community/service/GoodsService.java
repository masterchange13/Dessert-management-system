package com.example.community.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.community.entity.Goods;

import java.util.List;

public interface GoodsService extends IService<Goods> {

    void updateBatchStatus(List<Long> idList, Integer status);

    void updateStatus(Long id, Integer status);
}
