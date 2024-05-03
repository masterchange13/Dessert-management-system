package com.example.community.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.community.entity.Store;

import java.util.List;

public interface StoreService extends IService<Store> {
    void updateBatchStatus(List<Long> idList, Integer status);
    void updateStatus(Long id, Integer status);
}
