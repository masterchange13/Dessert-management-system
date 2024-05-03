package com.example.community.dto;

import com.example.community.entity.Store;
import lombok.Data;

@Data
public class StoreDto extends Store {

    private String categoryName;
}
