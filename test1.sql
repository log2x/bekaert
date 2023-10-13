 update bekaert_db.cms_page b 
join test1.cms_page t on b.identifier = t.identifier 
set b.title = t.title,
 b.page_layout = t.page_layout,
 b.meta_keywords = t.meta_keywords,
 b.meta_description = t.meta_description,
 b.content_heading = t.content_heading,
 b.content = t.content,
 b.creation_time = t.creation_time,
 b.update_time = t.update_time,
 b.is_active = t.is_active,
 b.sort_order = t.sort_order,
 b.layout_update_xml = t.layout_update_xml,
 b.custom_theme = t.custom_theme,
 b.custom_root_template = t.custom_root_template,
 b.custom_layout_update_xml = t.custom_layout_update_xml,
 b.layout_update_selected = t.layout_update_selected,
 b.custom_theme_from = t.custom_theme_from,
 b.custom_theme_to = t.custom_theme_to,
 b.meta_title = t.meta_title,
 b.website_root = t.website_root,
 b.created_in = t.created_in,
 b.updated_in = t.updated_in,
 b.top_banner_background_image = t.top_banner_background_image,
 b.cover_image = t.cover_image,
 b.cover_background_image = t.cover_background_image,
 b.cover_background_color = t.cover_background_color,
 b.subtitle = t.subtitle,
 b.short_description = t.short_description,
 b.is_include_search = t.is_include_search,
 b.is_excluded_from_search_result = t.is_excluded_from_search_result,
 b.content_text = t.content_text,
 b.page_header_render = t.page_header_render,
 b.news_date = t.news_date,
 b.display_mode = t.display_mode,
 b.news_sort_direction = t.news_sort_direction,
 b.news_redirect_url = t.news_redirect_url
where t.identifier in ('sound-attenuation', 'bekiporr-food-and-beverage-filter-media', 'bekiporr-hepa-ulpa-filter-media', 'bekiporr-hepa-ulpa-medical-filter-media', 'bekiporr-hot-gas-filter-media', 'hydraulic-oil-filter-felt', 'catalyst-substrates', 'coalescing-demisting', 'exhaust-filtration-media', 'fuel-and-lube-oil-filtration-media', 'inkjet-filtration-media', 'polymer-filtration-media');



---------+---------+
| page_id | page_id |
+---------+---------+
|      11 |      11 |
|     163 |     163 |
|     164 |     164 |
|     165 |     165 |
|     166 |     166 |
|     167 |     167 |
|     169 |     169 |
|     170 |     170 |
|     265 |     250 |
|     266 |     251 |
|     267 |     252 |
|     268 |     253 |
+---------+---------+

