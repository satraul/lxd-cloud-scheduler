#
# Cookbook:: ruby_rbenv
# Library:: Chef::Rbenv::ShellHelpers
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
#
# Copyright:: 2011-2017, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class Chef
  module Rbenv
    module ScriptHelpers
      def wrap_shim_cmd(cmd)
        [%(export RBENV_ROOT="#{rbenv_root}"),
         %(export PATH="$RBENV_ROOT/bin:$RBENV_ROOT/shims:$PATH"),
         %(export RBENV_VERSION="#{new_resource.rbenv_version}"),
         %($RBENV_ROOT/shims/#{cmd}),
        ].join(' && ')
      end

      # Execute the supplied block of code as the given user.
      def run_as_user(username)
        if username
          user = Etc.getpwnam(username)
          Process.fork do
            Process.uid = user.uid
            yield
          end
          Process.wait
        else
          yield
        end
      end

      def root_path
        node.run_state['root_path'] ||= {}

        if new_resource.user
          node.run_state['root_path'][new_resource.user]
        else
          node.run_state['root_path']['system']
        end
      end

      def which_rbenv
        "(#{new_resource.user || 'system'})"
      end
    end
  end
end
