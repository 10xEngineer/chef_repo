# providers/app.rb
#
# java_app provider wraps basic functionality for deploying Java based (Maven) application

include JavaApplication

def get_artefact
	puts '--- get_artefact'

	if new_resource.source == :local
		location = "/var/10xlab"
	end

	spec = application_spec(location)

	build_artefact(spec)
end

def build_artefact(spec)
	# FIXME hardcoded root"
	lab_home = "/var/10xlab"

	target_artefact = "target/#{spec[:artifactId]}.#{spec[:packaging]}"
	artefact_location = ::File.join(lab_home, target_artefact)

	unless ::File.exists?(artefact_location)
		command = %Q{cd /var/10xlab && mvn package}

		batch = Chef::Resource::Script::Bash.new "build maven artefact", run_context
		batch.code command
		batch.run_action(:run)
	end

	# FIXME move artefact
end

def deploy_app(res)
end

action :deploy do
	# <java_app[demo1] @resource_name: :java_app @name: "demo1" @noop: nil @before: nil @params: {} @provider: nil @allowed_actions: [:nothing, :deploy] @action: [:deploy] @updated: false @updated_by_last_action: false @supports: {} @ignore_failure: false @retries: 0 @retry_delay: 2 @sou rce_line: "/var/10xlab/cookbooks/sample_app/recipes/default.rb:1:in `from_file'" @elapsed_time: 0 @cookbook_name: :sample_app @recipe_name: "default">

	get_artefact
	#deploy_app(new_resource)
end