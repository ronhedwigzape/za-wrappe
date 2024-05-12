<template>
    <div class="tw-relative tw-flex tw-w-full tw-max-h-[800px] tw-aspect-square">
        <SfScrollable
            ref="thumbsRef"
            class="tw-items-center tw-w-full [&::-webkit-scrollbar]:tw-hidden [-ms-overflow-style:none] [scrollbar-width:none]"
            direction="vertical"
            :active-index="activeIndex"
            :previous-disabled="activeIndex === 0"
            :next-disabled="activeIndex === addOns.length - 1"
            buttons-placement="floating"
        >
            <template #previousButton="defaultProps">
                <SfButton
                    v-if="!firstThumbVisible"
                    v-bind="defaultProps"
                    :disabled="activeIndex === 0"
                    class="tw-absolute !tw-rounded-full tw-z-10 tw-top-4 tw-rotate-90 tw-bg-white"
                    variant="secondary"
                    size="sm"
                    square
                >
                    <SfIconChevronLeft size="sm" />
                </SfButton>
            </template>
            <div
                v-for="(addOn, index) in addOns"
                :key="`${addOn.name}-${index}-thumbnail`"
                :ref="(el) => assignRef(el, index)"
                :aria-label="addOn.name"
                :aria-current="activeIndex === index"
                :class="thumbnailClass(addOn, index)"
                @click="selectAddOn(addOn, index)"
                @mouseover="activeIndex = index"
                @focus="activeIndex = index"
                class="tw-relative type-button"
            >
                <img
                    :alt="addOn.name"
                    width="88"
                    height="88"
                    class="tw-border tw-border-neutral-200"
                    :src="`../img/${addOn.image_url}`"
                    :class="{'tw-border-2 tw-border-green-950 tw-opacity-50': isSelected(addOn)}"
                />
                <div
                    v-if="isSelected(addOn)"
                    class="tw-absolute tw-inset-0 tw-flex tw-justify-center tw-items-center"
                >
                    <svg class="tw-w-6 tw-h-6 tw-text-green-800" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                    </svg>
                </div>
            </div>
            <template #nextButton="defaultProps">
                <SfButton
                    v-if="!lastThumbVisible"
                    v-bind="defaultProps"
                    :disabled="activeIndex === addOns.length"
                    class="tw-absolute !tw-rounded-full tw-z-10 tw-bottom-4 tw-rotate-90 tw-bg-white"
                    variant="secondary"
                    size="sm"
                    square
                >
                    <SfIconChevronRight size="sm" />
                </SfButton>
            </template>
        </SfScrollable>
        <SfScrollable
            class="tw-w-full tw-h-full tw-snap-x tw-snap-mandatory [&::-webkit-scrollbar]:tw-hidden [-ms-overflow-style:none] [scrollbar-width:none]"
            :active-index="activeIndex"
            direction="vertical"
            wrapper-class="tw-h-full tw-m-auto"
            is-active-index-centered
            buttons-placement="none"
            :drag="{ containerWidth: true }"
            @on-drag-end="onDragged"
        >
            <div
                v-for="(addOn, index) in addOns"
                :key="`${addOn.name}-${index}`"
                @click="selectAddOn(addOn, index)"
                class="tw-flex tw-justify-center tw-h-full tw-basis-full tw-shrink-0 tw-grow tw-snap-center tw-relative"
            >
                <img
                    :aria-label="addOn.name"
                    :aria-hidden="activeIndex !== index"
                    class="tw-object-cover tw-w-auto tw-h-full"
                    :alt="addOn.name"
                    :src="`../img/${addOn.image_url}`"
                />
                <!-- Add-on name overlay at the bottom of the image -->
                <div class="tw-absolute tw-bottom-0 tw-w-full tw-text-center tw-text-white tw-bg-black tw-bg-opacity-50 tw-py-2">
                    {{ addOn.name }}
                </div>
            </div>
        </SfScrollable>
    </div>
</template>

<script setup>
import { ref, watch, computed } from 'vue';
import {
    SfScrollable,
    SfButton,
    SfIconChevronLeft,
    SfIconChevronRight,
} from '@storefront-ui/vue';
import {useOrderStore} from "@/stores/store-order.js";
import { useIntersectionObserver, unrefElement } from '@vueuse/core';

const props = defineProps({
    addOns: Array
});

const orderStore = useOrderStore();
const thumbsRef = ref(null);
const firstThumbRef = ref(null);
const lastThumbRef = ref(null);
const firstThumbVisible = ref(false);
const lastThumbVisible = ref(false);
const activeIndex = ref(0);

watch(
    thumbsRef,
    (newVal) => {
        if (newVal) {
            useIntersectionObserver(
                firstThumbRef,
                ([{ isIntersecting }]) => {
                    firstThumbVisible.value = isIntersecting;
                },
                {
                    root: unrefElement(thumbsRef),
                    rootMargin: '0px',
                    threshold: 1,
                },
            );
            useIntersectionObserver(
                lastThumbRef,
                ([{ isIntersecting }]) => {
                    lastThumbVisible.value = isIntersecting;
                },
                {
                    root: unrefElement(thumbsRef),
                    rootMargin: '0px',
                    threshold: 1,
                },
            );
        }
    },
    { immediate: true },
);

const onDragged = ({ swipeRight, swipeLeft }) => {
    if (swipeRight && activeIndex.value > 0) {
        activeIndex.value -= 1;
    } else if (swipeLeft && activeIndex.value < props.addOns.length - 1) {
        activeIndex.value += 1;
    }
};

const assignRef = (el, index) => {
    if (!el) return;
    if (index === props.addOns.length - 1) {
        lastThumbRef.value = el;
    } else if (index === 0) {
        firstThumbRef.value = el;
    }
};

function thumbnailClass(addOn, index) {
    return [
        'md:tw-w-[78px] md:tw-h-auto tw-relative tw-shrink-0 tw-pb-1 tw-mx-4 -mb-2 tw-border-b-4 tw-snap-start tw-cursor-pointer focus-visible:tw-outline focus-visible:tw-outline-offset tw-transition-colors tw-flex-grow md:tw-flex-grow-0',
        {
            'tw-border-primary-700': activeIndex.value === index,
            'tw-opacity-50': !addOn.active
        }
    ];
}

function selectAddOn(addOn, index) {
    orderStore.toggleAddOn(addOn);
    activeIndex.value = index;
}

const isSelected = (addOn) => {
    return orderStore.selectedAddOns.some(a => a.id === addOn.id);
}
</script>
