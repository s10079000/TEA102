package com.productPicture.model;

import java.util.List;

public class ProductPictureService {

	private ProductPictureDAOInterface dao;
	
	public ProductPictureService() {
		dao = new ProductPictureJDBCDAO();
	}
	
	public ProductPictureVO addProductPicture(byte[] picture, String pid) {
		ProductPictureVO ppVO = new ProductPictureVO();
		ppVO.setPp_picture(picture);
		ppVO.setP_id(pid);
		dao.insert(ppVO);
		return ppVO;
	}
	
	public void updateProductPocture(String ppid, byte[] picture) {
		ProductPictureVO ppVO = new ProductPictureVO();
		ppVO.setPp_id(ppid);
		ppVO.setPp_picture(picture);
		dao.update(ppVO);
	}
	
	public void deleteProductPicture(String pid) {
		dao.delete(pid);
	}
	
	public ProductPictureVO findOneProductPicture(String ppid) {
		return dao.findByPrimaryKey(ppid);
	}
	
	public List<ProductPictureVO> findProductPicture(String pid) {
		return dao.findByProduct(pid);
	}
	
	public List<ProductPictureVO> getAll() {
		return dao.getAll();
	}
}
