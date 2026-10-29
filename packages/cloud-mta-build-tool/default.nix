{
  supportedSystems,

  lib,

  buildGoModule,
  fetchFromGitHub
}: buildGoModule rec {
  pname = "Cloud MTA Build Tool";
  version = "1.2.50";

  src = fetchFromGitHub {
    owner = "SAP";
    repo = "cloud-mta-build-tool";
    rev = "refs/tags/v${version}";
    hash = "sha256-vJ6gWz3KLkStDN/M7r7/HN4xI8+hxXmjmqZZ7gG2BwE=";
  };
  vendorHash = "sha256-c+aqYeAMnUnZzRTLuEcXdlnJmLQs9cKUVzBG23ncDnk=";

  ldflags = ["-s" "-w" "-X main.Version=${version}"];

  doCheck = false;

  postInstall = ''
    pushd "''${out}/bin" &> /dev/null
    ln --symbolic 'cloud-mta-build-tool' 'mbt'
    popd
  '';

  meta = with lib; {
    description = "Multi-Target Application (MTA) build tool for Cloud Applications";
    homepage = "https://sap.github.io/cloud-mta-build-tool";
    license = licenses.asl20;
    changelog = "https://github.com/SAP/cloud-mta-build-tool/releases/tag/v${version}";
    platforms = supportedSystems;
    sourceProvenance = [ lib.sourceTypes.fromSource ];
  };
}
