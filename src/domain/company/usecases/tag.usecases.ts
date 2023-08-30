import { redirect } from "react-router-dom";
import { WrapperDto } from "../../../core/dto/wrapper.dto";
import {
  createTag,
  fetchTag,
  fetchTags,
  updateTag,
} from "../../../infrastracture/company/tag/tag.fetcher";
import { Tag } from "../entity/tag.entity";

export async function loadTags(): Promise<WrapperDto<Tag>> {
  const tags: WrapperDto<Tag> = await fetchTags();
  return tags;
}

export async function loadTag(req: any): Promise<WrapperDto<Tag>> {
  const tag: WrapperDto<Tag> = await fetchTag(req.params.tagID);
  return tag;
}

export async function editTag(req: any): Promise<void> {
  const formData = await req.request.formData();
  const updates = Object.fromEntries(formData);

  const tag: WrapperDto<Tag> = await updateTag(req.params.tagID, updates);
  if (tag.isSuccesful()) {
    redirect(`/tags/${req.params.tagID}`);
  } else {
    //show Error
  }
}

export async function addTag(req: any): Promise<void> {
  const formData = await req.request.formData();
  const updates = Object.fromEntries(formData);

  const tag: WrapperDto<Tag> = await createTag(updates);
  if (tag.isSuccesful()) {
    redirect(`/tags/${req.params.tagID}`);
  } else {
    //show Error
  }
}

// export async function action() {
//   const tag = await createTag();
//   return { tag };
// }
