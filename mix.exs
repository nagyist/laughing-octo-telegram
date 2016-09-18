defmodule Fw.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi2"

  def project do
    [app: :fw,
     version: "0.0.1",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.1.4"],
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     config_path: "config/config.exs",
     aliases: aliases,
     deps: deps ++ system(@target)]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Fw, []},
     applications: [:logger, :nerves_networking, :nerves_interim_wifi, :nerves_firmware_http]]
  end

  def deps do
    [{:nerves, "~> 0.3.0"},
     {:nerves_firmware_http, github: "nerves-project/nerves_firmware_http"},
     {:nerves_networking, github: "nerves-project/nerves_networking"},
     {:controller, path: "../elixir-poc"},
     {:nerves_interim_wifi, github: "nerves-project/nerves_interim_wifi" }]
  end

  def system(target) do
    [{:"nerves_system_#{target}", ">= 0.0.0"}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end
end
