{ lib, python3Packages, ... }:

python3Packages.buildPythonPackage rec {
   pname = "comfyui-dependencies";
   version = "1.0";
   src = "/home/zozano/test-shell/ComfyUI/requirements.txt";

   propagatedBuildInputs = with python3Packages; [
    comfyui-frontend-package
    comfyui-workflow-templates
    torch
    torchsde
    torchvision
    torchaudio
    numpy
    einops
    transformers
    tokenizers
    sentencepiece
    safetensors
    aiohttp
    yarl
    pyyaml
    Pillow
    scipy
    tqdm
    psutil
    kornia
    spandrel
    soundfile
    av
    pydantic
   ];

   meta = with lib; {
      description = "ComfyUI dependencies";
      license = licenses.mit;
   };

};
