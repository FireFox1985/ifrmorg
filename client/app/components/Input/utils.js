// @flow
import { REQUIRES_DEFAULT, DEFAULT_WITH_LABEL } from './InputDefault';

export const TYPES: string[] = REQUIRES_DEFAULT.concat([
  'textarea',
  'submit',
  'checkbox',
  'select',
  'checkboxGroup',
  'tag',
  'switch',
  'password',
  'location',
]);

export const REQUIRES_LABEL: string[] = DEFAULT_WITH_LABEL.concat([
  'textarea',
  'select',
  'checkboxGroup',
  'tag',
  'switch',
]);

export const REQUIRED_POSSIBLE: string[] = DEFAULT_WITH_LABEL.concat([
  'textarea',
  'checkboxGroup',
]);

export type Option = {
  id: string,
  value: any,
  label: string,
};

export type Checkbox = {
  id: string,
  name?: string,
  value: any,
  checked?: boolean,
  uncheckedValue?: any,
  label: string,
  onChange?: Function,
  info?: string,
};

export type Props = {
  id: string,
  type: | 'text'
    | 'textarea'
    | 'submit'
    | 'checkbox'
    | 'number'
    | 'time'
    | 'date'
    | 'select'
    | 'checkboxGroup'
    | 'tag'
    | 'hidden'
    | 'switch'
    | 'location'
    | 'password',
  name: string,
  label?: string,
  text?: string,
  show?: boolean,
  placeholder?: string,
  error?: boolean,
  dark?: boolean,
  small?: boolean,
  large?: boolean,
  value?: any,
  ariaLabel?: string,
  readOnly?: boolean,
  disabled?: boolean,
  required?: boolean,
  info?: string,
  minLength?: number,
  maxLength?: number,
  onClick?: Function,
  onChange?: Function,
  checked?: boolean,
  uncheckedValue?: any,
  min?: number,
  max?: number,
  options?: Option[],
  checkboxes?: Checkbox[],
  onError?: Function,
  accordion?: boolean,
  myRef?: any,
  accordionOpen?: boolean,
  formNoValidate?: boolean,
  googleAPIKey?: string,
  copyOnClick?: string,
};
