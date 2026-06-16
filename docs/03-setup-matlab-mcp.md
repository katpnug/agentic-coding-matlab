# 3. Set up MATLAB access for your agent

*Time: 10-15 minutes. This connects your agent to MATLAB.*

We use the official
[MATLAB Agentic Toolkit](https://github.com/matlab/matlab-agentic-toolkit).
It installs the MATLAB MCP Core Server for you and can also add MATLAB skills
to supported agents.

The important beginner idea is:

> Do this setup from MATLAB. Do not download the MCP server binary by hand
> unless an instructor asks you to troubleshoot manually.

Requirements:

- MATLAB R2021a or newer.
- Git installed.
- One MCP-capable agent from [step 2](02-setup-agent.md).

## 3.1 Install the MATLAB Agentic Toolkit

1. Download
   [agenticToolkitInstaller.mltbx](https://github.com/matlab/simulink-agentic-toolkit/releases/latest/download/agenticToolkitInstaller.mltbx).
2. Open the downloaded `.mltbx` file. MATLAB will install a small installer
   add-on.
3. In MATLAB, run:

   ```matlab
   setupAgenticToolkit("install")
   ```

4. When the installer asks what to install, choose the **MATLAB Agentic
   Toolkit**. You do not need the Simulink toolkit for this course.
5. When the installer asks about MATLAB session mode, choose the option that
   connects to an existing MATLAB session. This is usually shown as `auto` or
   `existing`.
6. When the installer asks where to configure your agent, choose **global** for
   this course unless an instructor tells you to use project-only setup.

The installer downloads the MCP server, configures your agent, and registers
the MATLAB skills it can use.

## 3.2 Choose only the skill groups you need

Install only the skill groups relevant to your work. Fewer skills make it
easier for the agent to choose the right one.

For this course, start small:

- **MATLAB Core** is useful for general MATLAB coding, debugging, and tests.
- **MATLAB Data Import and Analysis** is useful when you start working with
  tables or time-series data.

You can add more skill groups later by running the installer again:

```matlab
setupAgenticToolkit("install")
```

## 3.3 Restart your agent

After the installer finishes:

1. Close and reopen your agent or IDE.
2. Open this repository folder again.
3. Open MATLAB.

If you selected an existing MATLAB session mode, keep MATLAB open while you
work with the agent so figures and command output appear in the MATLAB session
you can see.

If the installer does not list your agent, stop and ask for help. The manual
MCP configuration is possible, but it is easier to make a typo and harder for
beginners to debug.

## 3.4 Verify the connection

Open the agent chat and ask:

> Using the MATLAB tools, tell me which MATLAB version and toolboxes I have
> installed.

The agent should call a MATLAB tool named something like
`detect_matlab_toolboxes` and report real version numbers.

Then ask:

> In MATLAB, plot a sine wave with a title that says "hello from my agent".

A figure window should appear in MATLAB.

If either step fails, see [troubleshooting](troubleshooting.md).

**Checkpoint:** the agent can run MATLAB code and you can see the figure.
Setup is done. Go to [module 0](../modules/module-0-hello-agent/README.md), or
read the [prompting guide](04-prompting-guide.md) first.
