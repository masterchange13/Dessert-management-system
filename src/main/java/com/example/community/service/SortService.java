package com.example.community.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.community.entity.Sort;

public interface SortService extends IService<Sort> {

    public void remove(Long id);

}
