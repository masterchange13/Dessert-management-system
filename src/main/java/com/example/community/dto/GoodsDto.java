package com.example.community.dto;

import com.example.community.entity.Goods;
import lombok.Data;

@Data
public class GoodsDto extends Goods {

    private String categoryName;

    private Integer copies;
}
