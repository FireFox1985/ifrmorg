# frozen_string_literal: true

module GroupsFormHelper
  include FormHelper

  def new_group_props
    new_form_props(group_form_inputs, groups_path)
  end

  def edit_group_props
    edit_form_props(group_form_inputs, group_path(@group))
  end

  private

  def group_form_inputs
    edit_inputs || common_inputs
  end

  def common_inputs
    [
      {
        id: 'group_name',
        type: 'text',
        name: 'group[name]',
        label: t('common.name'),
        value: @group&.name || nil,
        required: true,
        dark: true
      },
      {
        id: 'group_description',
        type: 'textarea',
        name: 'group[description]',
        label: t('common.form.description'),
        value: @group&.description || nil,
        required: true,
        dark: true
      }
    ]
  end

  def edit_inputs
    return unless action_name == 'edit' || action_name == 'update'

    inputs = common_inputs
    checkboxes = []
    @group.group_members.each do |member|
      path = profile_index_path(uid: member.user.uid)
      checkboxes.push(
        id: "group_leader_#{member.user_id}",
        name: 'group[leader][]',
        value: member.user_id,
        checked: member.leader,
        label: link_to(member.user.name, path)
      )
    end
    inputs.push(
      id: 'group_leader',
      name: 'group[leader]',
      type: 'checkboxGroup',
      checkboxes:,
      label: t('groups.form.leaders'),
      dark: true,
      required: true
    )
  end
end
