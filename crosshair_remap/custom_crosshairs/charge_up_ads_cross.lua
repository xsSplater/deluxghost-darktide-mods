local UIWidget = require("scripts/managers/ui/ui_widget")
local UIHudSettings = require("scripts/settings/ui/ui_hud_settings")
local template = {}
local length = 24
local thickness = 56
local size = {
	length,
	thickness
}
local cross_size = {
	8,
	4
}
local mask_size = {
	length,
	thickness - 4
}
local center_size = {
	4,
	4
}
local spread_distance = 10
local default_offset_x = 0
local default_offset_y = 0
local hit_default_distance = 10
local hit_size = {
	12,
	2
}
template.name = "charge_up_ads_cross"
template.size = size
template.cross_size = cross_size
template.hit_size = hit_size
template.center_size = center_size
template.spread_distance = spread_distance
template.hit_default_distance = hit_default_distance

local function apply_color_values(destination_color, target_color, include_alpha, optional_alpha)
	if include_alpha then
		destination_color[1] = target_color[1]
	end

	if optional_alpha then
		destination_color[1] = optional_alpha
	end

	destination_color[2] = target_color[2]
	destination_color[3] = target_color[3]
	destination_color[4] = target_color[4]

	return destination_color
end

template.create_widget_defintion = function (template, scenegraph_id)
	local size = template.size
	local cross_size = template.cross_size
	local mask_size = {
		size[1] - 4,
		size[2] - 4
	}
	local center_size = template.center_size
	local center_half_width = center_size[1] * 0.5
	local hit_size = template.hit_size
	local offset_charge = 120
	local offset_charge_right = {
		offset_charge + center_half_width,
		0,
		1
	}
	local offset_charge_mask_right = {
		offset_charge + center_half_width,
		0,
		2
	}
	local offset_charge_left = {
		-(offset_charge + center_half_width),
		0,
		1
	}
	local offset_charge_mask_left = {
		-(offset_charge + center_half_width),
		0,
		2
	}
	local hit_default_distance = template.hit_default_distance
	local offset_up = {
		0,
		-(cross_size[1] * 1.5 + center_half_width),
		1
	}
	local offset_down = {
		0,
		cross_size[1] * 1.5 + center_half_width - 1, -- -1 to compensate for human perception
		1
	}
	local offset_left = {
		-(cross_size[1] * 1.5 + center_half_width),
		0,
		1
	}
	local offset_right = {
		cross_size[1] * 1.5 + center_half_width,
		0,
		1
	}

	return UIWidget.create_definition({
		{
			value = "content/ui/materials/hud/crosshairs/default_center",
			style_id = "center",
			pass_type = "texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				offset = {
					0,
					0,
					0
				},
				size = center_size,
				color = UIHudSettings.color_tint_main_1
			}
		},
		{
			value = "content/ui/materials/hud/crosshairs/default_spread",
			style_id = "up",
			pass_type = "rotated_texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				angle = math.pi / 2,
				offset = offset_up,
				default_offset = offset_up,
				size = cross_size,
				color = UIHudSettings.color_tint_main_1
			}
		},
		{
			value = "content/ui/materials/hud/crosshairs/default_spread",
			style_id = "down",
			pass_type = "rotated_texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				angle = math.pi / 2,
				offset = offset_down,
				default_offset = offset_down,
				size = cross_size,
				color = UIHudSettings.color_tint_main_1
			}
		},
		{
			value = "content/ui/materials/hud/crosshairs/default_spread",
			style_id = "left",
			pass_type = "rotated_texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				offset = offset_left,
				default_offset = offset_left,
				size = cross_size,
				color = UIHudSettings.color_tint_main_1
			}
		},
		{
			value = "content/ui/materials/hud/crosshairs/default_spread",
			style_id = "right",
			pass_type = "rotated_texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				offset = offset_right,
				default_offset = offset_right,
				size = cross_size,
				color = UIHudSettings.color_tint_main_1
			}
		},
		{
			value = "content/ui/materials/hud/crosshairs/charge_up",
			style_id = "charge_left",
			pass_type = "texture_uv",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				uvs = {
					{
						1,
						0
					},
					{
						0,
						1
					}
				},
				offset = offset_charge_left,
				size = size,
				color = UIHudSettings.color_tint_main_1
			}
		},
		{
			value = "content/ui/materials/hud/crosshairs/charge_up",
			style_id = "charge_right",
			pass_type = "texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				offset = offset_charge_right,
				size = size,
				color = UIHudSettings.color_tint_main_1
			}
		},
		{
			value = "content/ui/materials/hud/crosshairs/charge_up_mask",
			style_id = "charge_mask_left",
			pass_type = "texture_uv",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				uvs = {
					{
						1,
						0
					},
					{
						0,
						1
					}
				},
				offset = offset_charge_mask_left,
				size = mask_size,
				color = UIHudSettings.color_tint_main_1
			}
		},
		{
			value = "content/ui/materials/hud/crosshairs/charge_up_mask",
			style_id = "charge_mask_right",
			pass_type = "texture_uv",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				uvs = {
					{
						0,
						1
					},
					{
						1,
						0
					}
				},
				offset = offset_charge_mask_right,
				size = mask_size,
				color = UIHudSettings.color_tint_main_1
			}
		},
		{
			value = "content/ui/materials/backgrounds/default_square",
			style_id = "hit_top_left",
			pass_type = "rotated_texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "right",
				offset = {
					-center_half_width - hit_default_distance,
					-center_half_width - hit_default_distance,
					0
				},
				size = {
					hit_size[1],
					hit_size[2]
				},
				pivot = {
					hit_size[1],
					hit_size[2] * 0.5
				},
				angle = -math.pi / 4,
				color = {
					255,
					255,
					255,
					0
				}
			}
		},
		{
			value = "content/ui/materials/backgrounds/default_square",
			style_id = "hit_bottom_left",
			pass_type = "rotated_texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "right",
				offset = {
					-center_half_width - hit_default_distance,
					center_half_width + hit_default_distance,
					0
				},
				size = {
					hit_size[1],
					hit_size[2]
				},
				pivot = {
					hit_size[1],
					hit_size[2] * 0.5
				},
				angle = math.pi / 4,
				color = {
					255,
					255,
					255,
					0
				}
			}
		},
		{
			value = "content/ui/materials/backgrounds/default_square",
			style_id = "hit_top_right",
			pass_type = "rotated_texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				offset = {
					center_half_width + hit_default_distance,
					-center_half_width - hit_default_distance,
					0
				},
				size = {
					hit_size[1],
					hit_size[2]
				},
				pivot = {
					0,
					hit_size[2] * 0.5
				},
				angle = math.pi / 4,
				color = {
					255,
					255,
					255,
					0
				}
			}
		},
		{
			value = "content/ui/materials/backgrounds/default_square",
			style_id = "hit_bottom_right",
			pass_type = "rotated_texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				offset = {
					center_half_width + hit_default_distance,
					center_half_width + hit_default_distance,
					0
				},
				size = {
					hit_size[1],
					hit_size[2]
				},
				pivot = {
					0,
					hit_size[2] * 0.5
				},
				angle = -math.pi / 4,
				color = {
					255,
					255,
					255,
					0
				}
			}
		}
	}, scenegraph_id)
end

template.on_enter = function (widget, template, data)
	return
end

template.update_function = function (parent, ui_renderer, widget, crosshair_template, crosshair_settings, dt, t)
	local content = widget.content
	local style = widget.style
	local hit_progress, hit_color = parent:hit_indicator()
	local yaw, pitch = parent:_spread_yaw_pitch(dt)
	local charge_level = parent:_get_current_charge_level() or 0

	if yaw and pitch then
		local spread_distance = template.spread_distance
		local spread_offset_y = spread_distance * pitch
		local spread_offset_x = spread_distance * yaw
		local charge_left_style = style.charge_left
		local charge_mask_left_style = style.charge_mask_left
		local charge_right_style = style.charge_right
		local charge_mask_right_style = style.charge_mask_right
		local up_style = style.up
		up_style.offset[2] = up_style.default_offset[2] - spread_offset_y
		local down_style = style.down
		down_style.offset[2] = down_style.default_offset[2] + spread_offset_y
		local left_style = style.left
		left_style.offset[1] = left_style.default_offset[1] - spread_offset_x
		local right_style = style.right
		right_style.offset[1] = right_style.default_offset[1] + spread_offset_x

		local crosshairs_fix = get_mod("crosshairs_fix")
		if crosshairs_fix and crosshairs_fix:is_enabled() then
			yaw, pitch = crosshairs_fix.spread_yaw_pitch(yaw, pitch)
			local up_style = widget.style.up
			local down_style = widget.style.down
			local left_style = widget.style.left
			local right_style = widget.style.right
			local styles = {right_style, up_style, left_style, down_style}
			for i = 1, 4 do
				styles[i].angle = math.rad(-90 + 90*i)
				styles[i].horizontal_alignment = "center"
				styles[i].vertical_alignment = "center"
				styles[i].offset[1] = math.cos(styles[i].angle) * (styles[i].size[1]/2 + yaw)
				styles[i].offset[2] = -math.sin(styles[i].angle) * (styles[i].size[1]/2 + pitch)
			end
		end
	end

	local mask_height = mask_size[2]
	local mask_height_charged = mask_height * charge_level
	local mask_height_offset_charged = mask_height * (1 - charge_level) * 0.5
	local charge_mask_right_style = style.charge_mask_right
	charge_mask_right_style.uvs[1][2] = charge_level
	charge_mask_right_style.size[2] = mask_height_charged
	charge_mask_right_style.offset[2] = mask_height_offset_charged
	local charge_mask_left_style = style.charge_mask_left
	charge_mask_left_style.uvs[1][2] = 1 - charge_level
	charge_mask_left_style.size[2] = mask_height_charged
	charge_mask_left_style.offset[2] = mask_height_offset_charged
	local hit_alpha = (hit_progress or 0) * 255

	if hit_alpha > 0 then
		local top_left_style = style.hit_top_left
		top_left_style.color = apply_color_values(top_left_style.color, hit_color or top_left_style.color, false, hit_alpha)
		top_left_style.visible = true
		local bottom_left_style = style.hit_bottom_left
		bottom_left_style.color = apply_color_values(bottom_left_style.color, hit_color or bottom_left_style.color, false, hit_alpha)
		bottom_left_style.visible = true
		local top_right_style = style.hit_top_right
		top_right_style.color = apply_color_values(top_right_style.color, hit_color or top_right_style.color, false, hit_alpha)
		top_right_style.visible = true
		local bottom_right_style = style.hit_bottom_right
		bottom_right_style.color = apply_color_values(bottom_right_style.color, hit_color or bottom_right_style.color, false, hit_alpha)
		bottom_right_style.visible = true
	else
		style.hit_top_left.visible = false
		style.hit_bottom_left.visible = false
		style.hit_top_right.visible = false
		style.hit_bottom_right.visible = false
	end
end

return template
