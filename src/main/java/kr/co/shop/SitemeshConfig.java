package kr.co.shop;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;

public class SitemeshConfig extends ConfigurableSiteMeshFilter{

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		builder.addDecoratorPath("*", "/default.jsp");
		builder.addExcludedPath("/product/jusoWrite");
		builder.addExcludedPath("/product/jusoList");
		builder.addExcludedPath("/product/jusoUpdate");
	}
	
}
