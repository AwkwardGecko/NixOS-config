{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs.python313Packages; [
    comfyui-manager # Custom-node manager extension for ComfyUI
    # comfyui-embedded-docs # Embedded node documentation for ComfyUI
    # comfyui-frontend-package # Frontend assets for ComfyUI
    # comfyui-workflow-templates # Workflow templates for ComfyUI
    # comfyui-workflow-templates-json # Workflow template JSON definitions for ComfyUI
    # comfyui-workflow-templates-core # Core loader for ComfyUI workflow templates
    # comfyui-workflow-templates-media-api # API workflow templates for ComfyUI
    # comfyui-workflow-templates-media-image # Image workflow templates for ComfyUI
    # comfyui-workflow-templates-media-video # Video workflow templates for ComfyUI
    # comfyui-workflow-templates-media-other # Additional workflow templates for ComfyUI
    # comfyui-workflow-templates-media-assets-01 # Media assets bundle 01 for ComfyUI workflow templates
    # comfy-aimdo # AI model dynamic offloader for ComfyUI
    # comfy-kitchen # Fast kernel library for ComfyUI with multiple compute backends
  ];
}
